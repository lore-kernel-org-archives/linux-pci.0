Return-Path: <SRS0=mUXL=K2=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=mUXL=K2=huawei.com=liudongdong3@kernel.org>
Subject: Re: [PATCH] PCI: Match Root Port's MPS to endpoint's MPSS when
 necessary
To: Myron Stowe <mstowe@redhat.com>
References: <20180718185158.149373.77902.stgit@tak.stowe>
 <20180801140507.GQ45322@bhelgaas-glaptop.roam.corp.google.com>
 <3f18a887-e669-f54d-1e89-36347cbfa44b@huawei.com>
 <20180810153319.53182e19@zim>
CC: Bjorn Helgaas <helgaas@kernel.org>, Myron Stowe <myron.stowe@redhat.com>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>, <keith.busch@intel.com>,
	<jdmason@kudzu.us>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <4fea21e5-c180-0df6-ebad-b5cba8b3c9ba@huawei.com>
Date: Sat, 11 Aug 2018 11:47:24 +0800
MIME-Version: 1.0
In-Reply-To: <20180810153319.53182e19@zim>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Myron

在 2018/8/11 5:33, Myron Stowe 写道:
> On Fri, 10 Aug 2018 18:04:39 +0800
> Dongdong Liu <liudongdong3@huawei.com> wrote:
>
>> Hi Bjorn, Myron
>>
>> I found a bug after applied the patch.
>>
>> The topology is as below. The 82599 netcard with two functions
>> connect to RP. +-[0000:80]-+-00.0-[81]--+-00.0  Device 8086:10fb
>>   |           |            \-00.1  Device 8086:10fb
>>
>> 1. lspci -s BDF -vvv  to get the value of device's MPSS , MPS and
>> MRRS. RP (80:00.0): MPSS=512 MPS=512 MRRS=512
>> EP PF0(81:00.0): MPSS=512 MPS=512 MRRS=512
>>     PF1(81:00.1): MPSS=512 MPS=512 MRRS=512
>>
>> 2. Enable SRIOV.
>> echo 1
>>> /sys/devices/pci0000\:80/0000\:80\:00.0/0000\:81\:00.0/sriov_numvfs
>>> RP(80:00.0): MPSS=512 MPS=128 MRRS=512
>>                            ^^^
>> EP PF0(81:00.0): MPSS=512 MPS=512 MRRS=512
>> 			      ^^^ 	
>>     PF1(81:00.1): MPSS=512 MPS=512 MRRS=512
>> 			      ^^^ 	
>>     VF0(81:10.0): MPSS=128 MPS=128 MRRS=128
>>                                ^^^
>> The 82599 netcard PF (MPSS 512) and VF's MPSS (MPSS 128) are
>> different. Then RP (MPS 128) will report Malformed TLP when PF0/PF1
>> has memory write operation with MPS 512.
>>
>> The 82599 netcard could work ok without the patch.
>> The values of MPSS, MPS, MRRS are as below without the patch.
>>
>> RP(80:00.0): MPSS=512 MPS=512 MRRS=512
>>                            ^^^
>> EP PF0(81:00.0): MPSS=512 MPS=512 MRRS=512
>> 			      ^^^ 	
>>     PF1(81:00.1): MPSS=512 MPS=512 MRRS=512
>> 			      ^^^ 	
>>     VF0(81:10.0): MPSS=128 MPS=128 MRRS=128
>>                                ^^^
>
> Hi Dongdong,
>
> Thanks for the testing and noticing a problem with the patch,
> especially before it was incorporated upstream!
>
>
> Looking into the PCI Express Base spec (4.0 r1.0), section 9.3.5.3
> concerning the "Device Capabilities Register", it indicates "PF and VF
> functionality is defined in Section 7.5.3.3 except where noted in
> Table 9-15".  Table 9-15 doesn't specifically mention anything with
> respect to MPSS which would make one _think_ that its respective VF's
> bits are valid.
Yes, very easy to misunderstand especially section 7.5.3.3 says
Max_Payload_Size Supported--
The Functions of a Multi-Function Device are permitted to report
different values for this field.
>
> However, section 9.3.5.4, concerning the "Device Control Register",
> does specifically show both Max_Payload_Size (MPS) and
> Max_Read_request_Size (MRRS) to be 'RsvdP' for VFs in Table 9-16
> [1].  Just prior to the table it states:
>   "PF and VF functionality is defined in Section 7.5.3.4 except where
>    noted in Table 9-16. For VF fields marked RsvdP, the PF setting
>    applies to the VF."
>
> All of which implies that with respect to MPSS, MPS, and MRRS values,
> we should _not_ be paying any attention to the VF's fields, but
> rather only to the PF's.  Only looking at the PF's fields also
> _logically_ makes sense as it is the sole physical interface to the
> PCIe bus.
Thanks for clarifying this.
>
>
> As to the patch, looks like an additional check as to if the
> device is a virtual function - 'dev->is_virtfn' - is needed where we
> bail out early in the case that it is.

Yes, that will be ok.
Thanks,
Dongdong

>
>
> [1] Per 7.4 "Configuration Register Types: 'RsvdP' fields are -
>       "Reserved for future RW implementations.  Register bits are
>        read-only and must return zero when read. Software must preserve
>        the value read for writes to bits."
>     which accounts for the MPS, and MRRS values being read as '0', and
>     thus subsequently intereptred as '128'.
>
>     Which brings up a tangental question: Should 'lspci' interpret,
>     and output, 'RsvdP' fields of the Device Control Register
>     corresponding to VFs?
>
> Myron
>
>>
>> Thanks,
>> Dongdong
> 在 2018/8/1 22:05, Bjorn Helgaas 写道:
>>
> snip O<
>
> .
>
