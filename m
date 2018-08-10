Return-Path: <SRS0=0EGJ=KZ=redhat.com=mstowe@kernel.org>
Return-Path: <SRS0=0EGJ=KZ=redhat.com=mstowe@kernel.org>
Date: Fri, 10 Aug 2018 15:33:19 -0600
From: Myron Stowe <mstowe@redhat.com>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Myron Stowe
 <myron.stowe@redhat.com>, <bhelgaas@google.com>,
 <linux-pci@vger.kernel.org>, <keith.busch@intel.com>, <jdmason@kudzu.us>
Subject: Re: [PATCH] PCI: Match Root Port's MPS to endpoint's MPSS when
 necessary
Message-ID: <20180810153319.53182e19@zim>
In-Reply-To: <3f18a887-e669-f54d-1e89-36347cbfa44b@huawei.com>
References: <20180718185158.149373.77902.stgit@tak.stowe>
	<20180801140507.GQ45322@bhelgaas-glaptop.roam.corp.google.com>
	<3f18a887-e669-f54d-1e89-36347cbfa44b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Fri, 10 Aug 2018 18:04:39 +0800
Dongdong Liu <liudongdong3@huawei.com> wrote:

> Hi Bjorn, Myron
>=20
> I found a bug after applied the patch.
>=20
> The topology is as below. The 82599 netcard with two functions
> connect to RP. +-[0000:80]-+-00.0-[81]--+-00.0  Device 8086:10fb
>   |           |            \-00.1  Device 8086:10fb
>=20
> 1. lspci -s BDF -vvv  to get the value of device's MPSS , MPS and
> MRRS. RP (80:00.0): MPSS=3D512 MPS=3D512 MRRS=3D512
> EP PF0(81:00.0): MPSS=3D512 MPS=3D512 MRRS=3D512
>     PF1(81:00.1): MPSS=3D512 MPS=3D512 MRRS=3D512
>=20
> 2. Enable SRIOV.
> echo 1
> > /sys/devices/pci0000\:80/0000\:80\:00.0/0000\:81\:00.0/sriov_numvfs
> > RP(80:00.0): MPSS=3D512 MPS=3D128 MRRS=3D512
>                            ^^^
> EP PF0(81:00.0): MPSS=3D512 MPS=3D512 MRRS=3D512
> 			      ^^^ =09
>     PF1(81:00.1): MPSS=3D512 MPS=3D512 MRRS=3D512
> 			      ^^^ =09
>     VF0(81:10.0): MPSS=3D128 MPS=3D128 MRRS=3D128
>                                ^^^
> The 82599 netcard PF (MPSS 512) and VF's MPSS (MPSS 128) are
> different. Then RP (MPS 128) will report Malformed TLP when PF0/PF1
> has memory write operation with MPS 512.
>=20
> The 82599 netcard could work ok without the patch.
> The values of MPSS, MPS, MRRS are as below without the patch.
>=20
> RP(80:00.0): MPSS=3D512 MPS=3D512 MRRS=3D512
>                            ^^^
> EP PF0(81:00.0): MPSS=3D512 MPS=3D512 MRRS=3D512
> 			      ^^^ =09
>     PF1(81:00.1): MPSS=3D512 MPS=3D512 MRRS=3D512
> 			      ^^^ =09
>     VF0(81:10.0): MPSS=3D128 MPS=3D128 MRRS=3D128
>                                ^^^

Hi Dongdong,

Thanks for the testing and noticing a problem with the patch,
especially before it was incorporated upstream!


Looking into the PCI Express Base spec (4.0 r1.0), section 9.3.5.3
concerning the "Device Capabilities Register", it indicates "PF and VF
functionality is defined in Section 7.5.3.3 except where noted in
Table 9-15".  Table 9-15 doesn't specifically mention anything with
respect to MPSS which would make one _think_ that its respective VF's
bits are valid.

However, section 9.3.5.4, concerning the "Device Control Register",
does specifically show both Max_Payload_Size (MPS) and
Max_Read_request_Size (MRRS) to be 'RsvdP' for VFs in Table 9-16
[1].  Just prior to the table it states:
  "PF and VF functionality is defined in Section 7.5.3.4 except where=20
   noted in Table 9-16. For VF fields marked RsvdP, the PF setting
   applies to the VF."

All of which implies that with respect to MPSS, MPS, and MRRS values,
we should _not_ be paying any attention to the VF's fields, but
rather only to the PF's.  Only looking at the PF's fields also
_logically_ makes sense as it is the sole physical interface to the
PCIe bus.


As to the patch, looks like an additional check as to if the
device is a virtual function - 'dev->is_virtfn' - is needed where we
bail out early in the case that it is.


[1] Per 7.4 "Configuration Register Types: 'RsvdP' fields are -
      "Reserved for future RW implementations.  Register bits are
       read-only and must return zero when read. Software must preserve
       the value read for writes to bits."
    which accounts for the MPS, and MRRS values being read as '0', and
    thus subsequently intereptred as '128'.

    Which brings up a tangental question: Should 'lspci' interpret,
    and output, 'RsvdP' fields of the Device Control Register
    corresponding to VFs?

Myron

>=20
> Thanks,
> Dongdong
=E5=9C=A8 2018/8/1 22:05, Bjorn Helgaas =E5=86=99=E9=81=93:
>
snip O<
