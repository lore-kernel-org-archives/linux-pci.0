Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:14021 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390Ab3DTFs2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 20 Apr 2013 01:48:28 -0400
Message-ID: <51722C04.1000904@huawei.com>
Date: Sat, 20 Apr 2013 13:47:48 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Frank Rizzo <thefrankrizzo@hotmail.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Rescan PCIE bus to find recently powered on device.
References: <SNT136-W425B9A4DBEA719E570080DB2C80@phx.gbl> <5170B9BD.6040408@huawei.com> <CAErSpo43xWdYE8MT9Y4Hdi0bkNh3D4Su6zThAVs72+nYiUD5qg@mail.gmail.com> <BLU0-SMTP305A7D1308063E03F4C5CE9B2C90@phx.gbl> <5171F610.80001@huawei.com> <BLU0-SMTP185893DF37F0C811FA0BCB7B2C90@phx.gbl> <517204AE.9030907@huawei.com> <BLU0-SMTP106EAAAE910BEDD2F047B19B2C90@phx.gbl>
In-Reply-To: <BLU0-SMTP106EAAAE910BEDD2F047B19B2C90@phx.gbl>
Content-Type: text/plain; charset="ISO-8859-15"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2013/4/20 11:26, Frank Rizzo wrote:
> On Fri, 19 Apr 2013 19:59:58 -0700, Yijing Wang <wangyijing@huawei.com> wrote:
> 
>> On 2013/4/20 10:22, Frank Rizzo wrote:
>>> (with device powered on AFTER boot)
>>>
>>> root@frank-System-Product-Name:~# echo 1 > /sys/bus/pci/rescan
>>
>> Hi Frank,
>>    When you do rescan here, any new message info will print in dmesg?
>> Compare the two lspci info, it seems like your external device is
>> 02.0-[02]----00.0  Device 1a39:0004, which include a pci bridge and a pci endpoint device.
>> But let me confused is that after you rescan (with device powered on AFTER boot),
>> there is no any new device found, normally, at least we should found the bridge device.
>> Maybe the link between host bridge and your external device got some problems? I am not sure.
> 
> 
> Yijing, when powered on, the device works fine.  I can talk to all the registers, and do everything that I need to do.  This "late power-on issue" is the only thing holding me back.
> 

Yes, in "late power-on issue" case, seems linux cannot enumerate your external device(both the bridge device and endpoint device).
Maybe when do rescan, linux cannot read the device vendor id register success.

Frank, Are there other slots in your platform ? Or what will happen if your try to use other pci devices instead ?


> This is what I get in dmesg.  (Cleared first)
> 
> root@frank-System-Product-Name:~# dmesg -c
> (SNIP!)
> root@frank-System-Product-Name:~# echo 1 > /sys/bus/pci/rescan
> root@frank-System-Product-Name:~# dmesg
> [ 1180.917841] fglrx_pci 0000:01:05.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
> root@frank-System-Product-Name:~#
> 
> 


-- 
Thanks!
Yijing

