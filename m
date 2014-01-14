Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:49793 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905AbaANTH1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2014 14:07:27 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: "Karicheri, Muralidharan" <m-karicheri2@ti.com>
Cc: Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: pcie-designware: query on MSI IRQ handling
Date: Tue, 14 Jan 2014 20:07:25 +0100
Message-ID: <8531317.0KHgUNUhUY@wuerfel>
In-Reply-To: <3E54258959B69E4282D79E01AB1F32B704666887@DFLE11.ent.ti.com>
References: <3E54258959B69E4282D79E01AB1F32B704662F8F@DFLE11.ent.ti.com> <201401091239.20839.arnd@arndb.de> <3E54258959B69E4282D79E01AB1F32B704666887@DFLE11.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 14 January 2014 19:04:16 Karicheri, Muralidharan wrote:
> I agree on this layering. For our designware IP, the Legacy IRQ
> controller has 1 host irq per function where as common designware driver
> uses 1 irq for this. So the irq map function has to be different as well.

I would hope that the generic interrupt-map property parser can
handle this for any configuration without needing a special
map function.

	Arnd
