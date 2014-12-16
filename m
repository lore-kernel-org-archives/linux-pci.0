Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:60812 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751272AbaLPAIi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 15 Dec 2014 19:08:38 -0500
Date: Tue, 16 Dec 2014 00:08:22 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Krzysztof Halasa <khalasa@piap.pl>,
	Arnd Bergmann <arnd@arndb.de>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Mohit Kumar <mohit.kumar@st.com>
Subject: Re: [PATCH v3 0/2] arm: pcibios: remove pci_sys_data domain
Message-ID: <20141216000821.GM11285@n2100.arm.linux.org.uk>
References: <1416569367-29409-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20141215235248.GA4374@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141215235248.GA4374@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 15, 2014 at 04:52:48PM -0700, Bjorn Helgaas wrote:
> I provisionally applied these to my next-pci/domain branch.  This will be
> rebased after v3.19-rc1.
> 
> I'd like to see acks from Thomas and/or Jason for MVEBU, and Simon for
> R-Car.

And you should also have my acked-by for the core ARM code:

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
