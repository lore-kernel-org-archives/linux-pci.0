Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hq.vniiem.ru ([78.107.120.166]:52228 "EHLO mx.svc.vniiem.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753000AbcAXNtp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 24 Jan 2016 08:49:45 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx.svc.vniiem.ru (Postfix) with ESMTP id 5E23F820A7
	for <linux-pci@vger.kernel.org>; Sun, 24 Jan 2016 16:49:42 +0300 (MSK)
Received: from mx.svc.vniiem.ru ([127.0.0.1])
	by localhost (mx.svc.vniiem.ru [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cu70MVNRwRsW for <linux-pci@vger.kernel.org>;
	Sun, 24 Jan 2016 16:49:42 +0300 (MSK)
From: =?UTF-8?B?0J7Qu9C10LMg0JzQvtGA0L7Qtw==?= <oleg.moroz@mcc.vniiem.ru>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: PCI device driver broken between 4.2 and 4.3
References: <56A32702.7080909@mcc.vniiem.ru>
 <CAErSpo6MtFSxnH8uSqeLiJVR3P-R5DUX2Furw3yw8JiMN29H0A@mail.gmail.com>
Message-ID: <56A4D690.1020804@mcc.vniiem.ru>
Date: Sun, 24 Jan 2016 16:50:08 +0300
MIME-Version: 1.0
In-Reply-To: <CAErSpo6MtFSxnH8uSqeLiJVR3P-R5DUX2Furw3yw8JiMN29H0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Okay. I've sent logs (dmesg and lspci) from both 4.2 and 4.3 to bugzilla

23.01.2016 17:54, Bjorn Helgaas пишет:
> [+cc linux-kernel]
>
> Hi Олег,
>
> On Sat, Jan 23, 2016 at 1:08 AM, Олег Мороз <oleg.moroz@mcc.vniiem.ru> wrote:
>> Hello. I've got a device driver for MIL-1553b card called TA1-PCI, which
>> could be found at
>> https://github.com/qmor/elcus-1553-driver-linux
>> Card is using PLX_PCI9030 PCI controller.
>> Today i've found that this driver compiles, installes, but is not working as
>> it should.
>> Looks like it not receives any interrupts from PCI. I've test it again with
>> kernel
>> 4.2 and it works okay. What changes was made in PCI subsystem from 4.2 to
>> 4.3
>> which could have impact this driver work.
> Thank you very much for this problem report.  There were many PCI
> changes between v4.2 and v4.3, and without more information, I can't
> guess what might be causing this problem.
>
> I opened a bug report at https://bugzilla.kernel.org/show_bug.cgi?id=111211
>
> Please attach complete dmesg logs for both v4.2 and v4.3 to that bug
> report.  Also, please attach the complete "lspci -vv" output (as
> root).
>
> Thanks!
>
> Bjorn

