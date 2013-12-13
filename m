Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:57673 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926Ab3LMImi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 Dec 2013 03:42:38 -0500
Message-ID: <52AAC87B.6000007@arkona-technologies.de>
Date: Fri, 13 Dec 2013 09:42:35 +0100
From: Matthias Mann <M.Mann@arkona-technologies.de>
MIME-Version: 1.0
To: Matthias Mann <m.mann@arkona-technologies.de>
CC: Harro Haan <hrhaan@gmail.com>, Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>, Marek Vasut <marex@denx.de>,
	Pratyush Anand <pratyush.anand@st.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Siva Reddy Kallam <siva.kallam@samsung.com>,
	Richard Zhu <hong-xing.zhu@freescale.com>,
	linux-pci@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>,
	Srikanth T Shivanand <ts.srikanth@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sean Cross <xobs@kosagi.com>, Shawn Guo <shawn.guo@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pci: designware: fix missing msi irqs
References: <20131212182903.409515738@gmail.com> <52AA0EB2.2070701@arkona-technologies.de>
In-Reply-To: <52AA0EB2.2070701@arkona-technologies.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am 12.12.2013 20:29, schrieb Matthias Mann:
> Am 12.12.2013 19:29, schrieb Harro Haan:
>> The interrupts were cleared after the irq handler was called.
>> This means that new interrupts that occur after the handler handled
>> the previous irq but before the interrupt is cleared will be missed.
>
> I discovered the same issue today. I'll test that patch tomorrow.
>
I tested this patch on our custom i.MX6 board with an Altera FPGA as PCIe
device and it fixed the missed MSI interrupts.

Tested-by:  Matthias Mann <m.mann@arkona-technologies.de>

Regards
Matthias Mann

-- 

Matthias Mann
Research & Development

Phone: 	+49 (0) 6155 7802883
Fax: 	+49 (0) 6155 7802880
Email: 	M.Mann@arkona-technologies.de 
<mailto:M.Mann@arkona-technologies.de>
Web: 	www.arkona-technologies.de <http://www.arkona-technologies.de>

arkona technologies GmbH
Im Leuschnerpark 4
64347 Griesheim
Germany

Amtsgericht / Commercial Register of Darmstadt, HRB 90080
USt-ID: DE273794666
Steuernummer / Tax-ID: 007 / 228 / 19331
Geschäftsführung / Managing Director: Rainer Sturm

This e-mail may contain confidential and/or privileged information. If you are
not the intended recipient (or have received this e-mail in error) please notify
the sender immediately and delete this message and any attachments from your
system. Any unauthorised copying, disclosure or distribution of the material in
this e-mail is strictly forbidden.

We cannot accept any responsibility for the accuracy or completeness of this
message as it has been transmitted over a public network. If, despite our use of
anti-virus software, a virus enters your systems in connection with the sending
of the e-mail, you may not hold us liable for any damages that may possibly
arise in that connection. We will accept liability which by law we cannot exclude.

