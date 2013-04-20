Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from [65.55.111.171] ([65.55.111.171]:41077 "EHLO
	blu0-omc4-s32.blu0.hotmail.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S965593Ab3DTD0w (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Apr 2013 23:26:52 -0400
Message-ID: <BLU0-SMTP106EAAAE910BEDD2F047B19B2C90@phx.gbl>
Content-Type: text/plain; charset="iso-8859-15"; format=flowed; delsp=yes
To: "Yijing Wang" <wangyijing@huawei.com>
CC: "Bjorn Helgaas" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Rescan PCIE bus to find recently powered on device.
References: <SNT136-W425B9A4DBEA719E570080DB2C80@phx.gbl>
 <5170B9BD.6040408@huawei.com>
 <CAErSpo43xWdYE8MT9Y4Hdi0bkNh3D4Su6zThAVs72+nYiUD5qg@mail.gmail.com>
 <BLU0-SMTP305A7D1308063E03F4C5CE9B2C90@phx.gbl> <5171F610.80001@huawei.com>
 <BLU0-SMTP185893DF37F0C811FA0BCB7B2C90@phx.gbl> <517204AE.9030907@huawei.com>
Date: Fri, 19 Apr 2013 20:26:07 -0700
MIME-Version: 1.0
From: Frank Rizzo <thefrankrizzo@hotmail.com>
In-Reply-To: <517204AE.9030907@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 19 Apr 2013 19:59:58 -0700, Yijing Wang <wangyijing@huawei.com>  
wrote:

> On 2013/4/20 10:22, Frank Rizzo wrote:
>> (with device powered on AFTER boot)
>>
>> root@frank-System-Product-Name:~# echo 1 > /sys/bus/pci/rescan
>
> Hi Frank,
>    When you do rescan here, any new message info will print in dmesg?
> Compare the two lspci info, it seems like your external device is
> 02.0-[02]----00.0  Device 1a39:0004, which include a pci bridge and a  
> pci endpoint device.
> But let me confused is that after you rescan (with device powered on  
> AFTER boot),
> there is no any new device found, normally, at least we should found the  
> bridge device.
> Maybe the link between host bridge and your external device got some  
> problems? I am not sure.


Yijing, when powered on, the device works fine.  I can talk to all the  
registers, and do everything that I need to do.  This "late power-on  
issue" is the only thing holding me back.

This is what I get in dmesg.  (Cleared first)

root@frank-System-Product-Name:~# dmesg -c
(SNIP!)
root@frank-System-Product-Name:~# echo 1 > /sys/bus/pci/rescan
root@frank-System-Product-Name:~# dmesg
[ 1180.917841] fglrx_pci 0000:01:05.0: BAR 6: [??? 0x00000000 flags 0x2]  
has bogus alignment
root@frank-System-Product-Name:~#
