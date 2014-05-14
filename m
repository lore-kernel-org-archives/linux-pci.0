Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48192 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751070AbaENNCr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 14 May 2014 09:02:47 -0400
Message-ID: <5373695D.2090702@ti.com>
Date: Wed, 14 May 2014 16:02:21 +0300
From: Roger Quadros <rogerq@ti.com>
MIME-Version: 1.0
To: Kishon Vijay Abraham I <kishon@ti.com>,
	<devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC: <balajitk@ti.com>
Subject: Re: [PATCH 02/17] phy: omap-control: add external clock support for
 PCIe PHY
References: <1399383244-14556-1-git-send-email-kishon@ti.com> <1399383244-14556-3-git-send-email-kishon@ti.com>
In-Reply-To: <1399383244-14556-3-git-send-email-kishon@ti.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/06/2014 04:33 PM, Kishon Vijay Abraham I wrote:
> Export an API to be called by PIPE3 PHY to enable external clock for
> PCIE PHY. Added a new compatible for PCIE in omap-control in order to
> enable it.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Reviewed-by: Roger Quadros <rogerq@ti.com>

--
cheers,
-roger

