Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:35862 "EHLO
	mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950AbcD2Mwf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2016 08:52:35 -0400
Received: by mail-yw0-f178.google.com with SMTP id o66so185120179ywc.3
        for <linux-pci@vger.kernel.org>; Fri, 29 Apr 2016 05:52:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOMZO5AiaNFashMd6XEz=zjyodm6UEAuBMsK=otQ5nHeE+voqw@mail.gmail.com>
References: <1461167131-26025-1-git-send-email-andrew.smirnov@gmail.com>
	<1461167131-26025-2-git-send-email-andrew.smirnov@gmail.com>
	<CAOMZO5AiaNFashMd6XEz=zjyodm6UEAuBMsK=otQ5nHeE+voqw@mail.gmail.com>
Date: Fri, 29 Apr 2016 14:52:34 +0200
Message-ID: <CAAMH-yumeh+MUADCk7wbeSO-hdVLT82jmkn2swYmuD8HndrKFA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] PCI: imx6: Implement reset sequence for i.MX6+
From: Gary Bisson <gary.bisson@boundarydevices.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

On Fri, Apr 29, 2016 at 3:47 AM, Fabio Estevam <festevam@gmail.com> wrote:
> On Wed, Apr 20, 2016 at 12:45 PM, Andrey Smirnov
> <andrew.smirnov@gmail.com> wrote:
>> I.MX6+ has a dedicated bit for reseting PCIe core, which should be used
>> instead of a regular reset sequence since using the latter will hang the
>> SoC.
>>
>> This commit is based on c34068d48273e24d392d9a49a38be807954420ed from
>> http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git
>>
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

Tested on a Nitrogen6QP_MAX with an Intel WiFi Link 5300 PCIe card.
Everything is working properly (Gen1 speed).
# lspci
00:00.0 Class 0604: 16c3:abcd
01:00.0 Class 0280: 8086:4235

Tested-by: Gary Bisson <gary.bisson@boundarydevices.com>

Thanks,
Gary
