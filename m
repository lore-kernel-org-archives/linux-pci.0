Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:56643 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842Ab3HICkZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Aug 2013 22:40:25 -0400
Message-ID: <52045667.3080702@huawei.com>
Date: Fri, 9 Aug 2013 10:39:35 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Jon Mason <jdmason@kudzu.us>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH -v3] PCI: update device mps when doing pci hotplug
References: <1375776540-23988-1-git-send-email-wangyijing@huawei.com> <CAPoiz9wAufM8HV_Drdxg50zs5=1AduBUN5oXNRBHYqjwMCOTaQ@mail.gmail.com> <5201A877.2080303@huawei.com> <CAPoiz9z1yS=-GwWuBjbxCUk4s+K5KtEBLwaWsO5XVT_uePeHHg@mail.gmail.com> <520306E9.5050901@huawei.com> <CAPoiz9zDQjvj1jYyW=0+0=qX60gu-FSZTHpYj2Yq2okg1WDOXA@mail.gmail.com>
In-Reply-To: <CAPoiz9zDQjvj1jYyW=0+0=qX60gu-FSZTHpYj2Yq2okg1WDOXA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> Hi Jon,
>>    Thanks for your comments!
>> I think we can improve this logic a little . As your comments in pcie_find_smpss(), if the PCI hotplug
>> slot is directly connected to the root port and there are not other devices on the fabric, then this
>> is not an issue..  So I think in this case, we can first update the newly hot added device mps as above logic.
>> if newly hot added device mpss < root port mps, then we can modify both root port device and newly hot added device
>> mps to device mpss. What do you think?
>>
>> eg.
>> Root port --------------> slot (mps is default 128,assume mpss is 256)
>> (mps 512)
>>
>> Only in this case, I think we try to update the parent device is safe.
>>
>> after update:
>> Root port --------------> slot (mps is default 128,assume mpss is 256)
>> (mps 512-->256)         mps 128--->256
> 
> 
> Yes, but this is where it get difficult.  You can only do it if the
> parent bus is the root port.  Otherwise, the other devices on the bus
> will already have their MPS configured and changing the root port MPS
> will do bad things.  That is why I have the check in pcie_find_smpss()
> of
> 
>         if (dev->is_hotplug_bridge && (!list_is_singular(&dev->bus->devices) ||
>              (dev->bus->self &&
>               pci_pcie_type(dev->bus->self) != PCI_EXP_TYPE_ROOT_PORT)))
> 
> So, you either need to mimic this code in your new function or make
> PCIE_BUS_SAFE the default option.  I'm leaning towards the latter, but
> if you need something for the stable tree then we should temporarily
> have a patch which does it the former.
> 
> Thoughts?

Yes, I need one patch fix this issue in the stable tree. Will you send out
the series patch recently? Bjorn now began to review this mps code, so
this is a good chance to rework mps related codes I think.

> 
>>
>>>
>>>> But if we try to configure DP 1 mps to 128B, it's not safe. its parent Upstream port still is 256.
>>>
>>> This is exactly the case that the "PERFORMANCE" option is trying to
>>> allow.  If the MRRS is set to the MPS of the device, it should work.
>>> If not, then we should rip out all of the "PERFORMANCE" code.  Is this
>>> something you can verify?
>>
>> Hi Jon,
>>    I am not very clear about what the role of MRRS. So if I understand wrong, please correct me, thanks.
>>
>> eg.
>> DP1 ----------------> EP A
>> mps=256                 mps=128
>>
>> MRRS can control the read request TLP size when the Function as a Requester.
>> So if we set the EP A MRRS to mps value(128), EP A won't generate
>> TLP larger than 128, so Request stream from EP A to DP1 is safe.
>>
>> But if EP A is as a receiver, DP 1 generate completion TLP (larger than 128) to EP A.
>> these TLPs will be discarded by EP A, right?
> 
> Yes
> 
>> So in my idea, If we set both mps and mrrs of EP A to 128, we can insure TLPs stream from EP A is safe.
>> But How do we guarantee that DP1 won't generate TLPs to EP A is larger than 128?
> 
> The device will never do any reads of larger than the MRRS, but writes
> to the device are an issue.  Assuming that all I/O is between CPU/RAM
> and the device and there are no peer-to-peer transfers, we should be
> safe (but is that a safe assumption?).  So my question to you is that
> the setup you have that is failing due to MPS sizes being off, can you
> set the only MRRS to 128 and get it working?

I don't have PCIe analyzer, so I can not catch TLP, I'm not sure the TLPs size in stream.
my test is using ping $dest_ip -s 65500

local machine				remote machine
IP: 128.5.160.31			IP: 128.5.160.28	


Root port ---------------->Endpoint device(bnx2 NIC)
00:01.0				01:00.1

default setting
	Root Port(00:01.0):
	Capabilities: [90] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag+ RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes

	Endpoint device(01:00.1)
	Capabilities: [ac] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes

test1:
change root port mps to 256

Root port ---------------->EndPoint device(bnx2 NIC)
mps=256	(default 128)		mps=128
mrrs=128			mrrs=512(default)

result:
ping 128.5.160.28(remote ip) -s 65500  ----->fail
ping 128.5.160.31(remove machine ping local ip)------->fail

test2:
change root port mps to 256, EP device mrrs to 128


Root port ---------------->EndPoint device(bnx2 NIC)
mps=256	(default 128)		mps=128
mrrs=128			mrrs=128(default 512)

result:
ping 128.5.160.28(remote ip) -s 65500  ----->success
ping 128.5.160.31(remove machine ping local ip)------->success

It seems change mrrs to 128 take effect.

Thanks!
Yijing.

