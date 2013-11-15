Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41896 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932082Ab3KOF20 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Nov 2013 00:28:26 -0500
Message-ID: <5285B0E7.5000802@ti.com>
Date: Fri, 15 Nov 2013 10:58:07 +0530
From: Kishon Vijay Abraham I <kishon@ti.com>
MIME-Version: 1.0
To: Marek Vasut <marex@denx.de>
CC: Pratyush Anand <pratyush.anand@gmail.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Ajay KHANDELWAL <ajay.khandelwal@st.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [QUERY] Number of address translation regions in designware
References: <52652BF1.4040507@ti.com> <CAHM4w1=YkiYv_N0qxQpbfqz3VHQrZ46j96x0tCvL6q-oOLXtKA@mail.gmail.com> <527A0112.60908@ti.com> <201311150140.22501.marex@denx.de>
In-Reply-To: <201311150140.22501.marex@denx.de>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Friday 15 November 2013 06:10 AM, Marek Vasut wrote:
> Hi Kishon,
> 
> just curious, what's the current status of the DWC PCIe driver? How's the iATU 
> issue going? Can you please update us a little?

I was able to get it working in DRA7. Few of the dependent stuffs are not in
mainline yet (some clock related patches, rest framework changes, PHY changes).
Will post a RFC soon for pcie only part.

Thanks
Kishon
