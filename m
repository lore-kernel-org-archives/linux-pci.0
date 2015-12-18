Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:33919 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754369AbbLROlJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Dec 2015 09:41:09 -0500
MIME-Version: 1.0
In-Reply-To: <1450442339-18765-2-git-send-email-stanimir.varbanov@linaro.org>
References: <1450442339-18765-1-git-send-email-stanimir.varbanov@linaro.org>
	<1450442339-18765-2-git-send-email-stanimir.varbanov@linaro.org>
Date: Fri, 18 Dec 2015 20:11:07 +0530
Message-ID: <CAHM4w1kzGKahVOTdTxMciZBs81U9EVoSYPgCw9=ph3R9vSwCwQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] PCI: designware: ensure ATU is enabled before
 IO/conf space accesses
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Russell King <linux@arm.linux.org.uk>,
	Rob Herring <robh+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 18, 2015 at 6:08 PM, Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
> There is no guarantees that enabling ATU will hit the hardware
> immediately, and subsequent accesses to configuration / IO spaces
> are reliable. So fixing this by read back PCIE_ATU_CR2 register
> just after writing.
>
> Without such a fix the PCI device enumeration during kernel boot
> is not reliable, and reading configuration space for particular
> PCI device on the bus returns zero aka no device.
>
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>

Acked-by: Pratyush Anand <pratyush.anand@gmail.com>
