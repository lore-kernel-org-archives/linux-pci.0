Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:56543 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768AbaJYS7e convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 25 Oct 2014 14:59:34 -0400
Received: by mail-la0-f45.google.com with SMTP id gm9so2639957lab.32
        for <linux-pci@vger.kernel.org>; Sat, 25 Oct 2014 11:59:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <pryfyn2m266ess9s6pii03q3.1414196895183@email.android.com>
References: <1414117852-31657-1-git-send-email-richard.zhu@freescale.com>
	<1414117852-31657-2-git-send-email-richard.zhu@freescale.com>
	<CAOMZO5BttdTucmnbAu7ULHBkyp0kccu_qxTwf61y18sRST-0wg@mail.gmail.com>
	<pryfyn2m266ess9s6pii03q3.1414196895183@email.android.com>
Date: Sat, 25 Oct 2014 08:14:08 -0200
Message-ID: <CAOMZO5DB45h43Bezx87cU3_X_6XHN1CbvfaWiHr2G1AuSyHMUw@mail.gmail.com>
Subject: Re: Re: [PATCH V1] PCI: imx6: Wait the clocks to stabilize after ref_en
From: Fabio Estevam <festevam@gmail.com>
To: "Richard.Zhu@freescale.com" <Richard.Zhu@freescale.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Shengchao Guo <Shawn.Guo@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Tim Harvey <tharvey@gateworks.com>,
	m-karicheri2 <m-karicheri2@ti.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 24, 2014 at 10:31 PM, Richard.Zhu@freescale.com
<Richard.Zhu@freescale.com> wrote:
> Hi Fabio:
> This bug is found during the stress warm-reset stress test.
> There are about three times randomly link down issue during the consecutive
> 10000 times system warm reset tests on one customer’s golden board.
> Regarding to imx internal pcie design situation, synposys gave the
> suggestion, and it works.

Ok, great. Thanks for providing the details. I am happy with this patch.
