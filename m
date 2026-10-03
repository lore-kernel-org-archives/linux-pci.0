Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D79316199;
	Sat,  3 Oct 2026 20:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791057781; cv=none; b=tmu8f2Jvdi55AAh7J2LnnH0Z2tdHExQY2Oq0imKzpcxktGKdqG7tihQPz+c2+Eeg1gxK6GI8zJqTfualub3nPUgCM6+ZTNDrp9knAq/NZAAl5TsMnZcplrory8Zo2zkfNv1ZJ0M1iyAtJpIAXnreuut+/gWuCTmFa7cmKG3QkXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791057781; c=relaxed/simple;
	bh=c8RZlFZtWwmaML1poua5GS1WZz1umgtUQbubMOxhcUY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MQHhaLo9wBWiyvK4Qyq7KMj6a14CKTJ5YU3GMAFn7OIJlDLyhVkMAQc3UeJFrLZzokZjoVPP+Zmn4vUXhTFUVo9S2bsr7NSUmxo0kONoQyAfxw5vIpMpn1CwdcYHQqlCCvWBRa5G3902Q5mjMlt8mgInnbRKe7NLhB3qc6ezItY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=yEcSeKyl; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=AKgSvfc6; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yEcSeKyl";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="AKgSvfc6"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hxxQn1dQsz8v2k;
	Sat, 03 Oct 2026 22:02:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791057777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zmmEBhtUWrufi3v470m/nUJa9MdiHukGQfG4wGww2uI=;
	b=yEcSeKyljDZ7ZPpYnzXcF7PyGp5aR87Jxb9wzlNlMrBgpHDBgpdH9klQaMDPC4umPe6cRh
	v2zN0s61ijFhSSyyKsKS4mjPZbH+BGr09/ZJTQCjL+rzy4SLOQC/S6pkEbwu5DuCPZZ8pt
	a1XYZLadk3qzeFguxQgMXLwhjcAdN34RVuhzLn4aLEbJty4VV46evlOtFRDiBb+VmPUj2G
	jeEJCxG8+XW2qu/Bnr24m6oXhmSLzGl/FHhk0PNDpdEiXTxR4jucUxGJeMrmDhq8aZuLqi
	J1WaFuDKG2nBpearYdNUg6gMx6g8Ctp264lRX+V4yxbgLhWt1jhpO+j8uMUrjQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=AKgSvfc6;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <c038dbd9-7675-43a9-834c-915b6795dd50@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791057776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zmmEBhtUWrufi3v470m/nUJa9MdiHukGQfG4wGww2uI=;
	b=AKgSvfc634RjySaSkVdmNZd03hZnmLh/L090Qk5f4np74mE0hiMAVt0c/mMRw5CCRKrPkN
	nAbFmznEYW/mYYHKW3b0fR6SWdWWcp5JgzG8ciJbK57Ql1rehauWXhxqNGxna1ZP8gS6e2
	F09OY4skqDPL5OJnnd6t7+RbmZ0S2tevC/ijEFRMpcIxy6LlTmVdIyX6Q76Vn1+QixljLA
	Ynd7jc+L+ByWPDAazSQN6/03IfWxAiDWH7e5dgSeVodJ92mgb24eOhl0sS1vW1yqIcLFAM
	HMhhlSD5A/PpzvM8Ef9lHsuzrDveilPj8wdZGUTTCM3Y3NADN23QuoHagcHvqA==
Date: Sat, 3 Oct 2026 20:51:58 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/15] PCI: rcar-gen4: Check live link status in
 link_up()
From: Marek Vasut <marek.vasut@mailbox.org>
To: Koichiro Den <den@valinux.co.jp>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Niklas Cassel <cassel@kernel.org>, Wilfred Mallawa
 <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260928165230.3397664-1-den@valinux.co.jp>
 <20260928165230.3397664-3-den@valinux.co.jp>
 <d675e0ba-10f3-4503-bc2e-61977f4a5875@mailbox.org>
Content-Language: en-US
In-Reply-To: <d675e0ba-10f3-4503-bc2e-61977f4a5875@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: mybyrt1d9kfougszuarkdfr5rdtg7m4z
X-MBO-RS-ID: b901887ea3d6e6e77e3
X-Rspamd-Queue-Id: 4hxxQn1dQsz8v2k

On 10/3/26 8:29 PM, Marek Vasut wrote:
> On 9/28/26 6:52 PM, Koichiro Den wrote:
>> rcar_gen4_pcie_link_up() checks link state using SMLH_LINK_UP and
>> RDLH_LINK_UP in PCIEINTSTS0. However, these bits do not reflect the live
>> link state. On an R-Car S4, after taking down the endpoint, a link-down
>> interrupt saw PCIEINTSTS0 = 0x20a000c5 with both bits still set. Even
>> after resetting the controller with the LTSSM back in Polling, they read
>> 0xa000c5, still set.
>>
>> As a result, dw_pcie_link_up() keeps reporting the link as up after it
>> has gone down. That defeats the check in dw_pcie_other_conf_map_bus(),
>> which is supposed to stop config accesses to downstream devices while
>> the link is down, so such accesses go out on the dead link and stall the
>> host. It also makes the callback useless for the link-down recovery
>> added later, which has to wait for the link to actually come back after
>> resetting the controller.
>>
>> Keep the APP link-up event check from Figure 104.5 of the R-Car S4
>> reference manual, but also require PORT_DEBUG1 to report the link up and
>> not in training. The callback then rejects a downed link even if the APP
>> link-up events remain latched.
>>
>> Clear the APP latches before enabling LTSSM to discard events from a
>> previous start, and only read them in .link_up(). RC startup uses
>> dw_pcie_wait_for_link() to poll the combined condition.
>>
>> Fixes: 0d0c551011df ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller 
>> support for host mode")
>> Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> 
> I apologize for the late reply.
> 
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Tested-by: Marek Vasut <marek.vasut+renesas@mailbox.org> # R-Car V4H
> 
> Since next 20261002 now contains commit
> 
> f29719b5064c ("PCI: dwc: Align register macros with Synopsys 
> documentation")
> 
> This will need the following slight adjustment:
> 
> "s@PCIE_PORT_DEBUG@PORT_LINK_DEBUG@g"
> 
> "
> -       val = dw_pcie_readl_dbi(dw, PCIE_PORT_DEBUG1);
> -       return (val & PCIE_PORT_DEBUG1_LINK_UP) &&
> -              !(val & PCIE_PORT_DEBUG1_LINK_IN_TRAINING);
> +       val = dw_pcie_readl_dbi(dw, PORT_LINK_DEBUG1);
> +       return (val & PORT_LINK_DEBUG1_LINK_UP) &&
> +              !(val & PORT_LINK_DEBUG1_LINK_IN_TRAINING);
> "

A small nitpick, would the following change make sense to reduce 
duplication a bit ?

diff --git a/drivers/pci/controller/dwc/pcie-designware.c 
b/drivers/pci/controller/dwc/pcie-designware.c
index c726aa71c830c..52bdb1fcc2db2 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -817,17 +817,23 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
  }
  EXPORT_SYMBOL_GPL(dw_pcie_wait_for_link);

-bool dw_pcie_link_up(struct dw_pcie *pci)
+bool dw_pcie_link_up_debug_check(struct dw_pcie *pci)
  {
         u32 val;

-       if (pci->ops && pci->ops->link_up)
-               return pci->ops->link_up(pci);
-
         val = dw_pcie_readl_dbi(pci, PORT_LINK_DEBUG1);
         return ((val & PORT_LINK_DEBUG1_LINK_UP) &&
                 (!(val & PORT_LINK_DEBUG1_LINK_IN_TRAINING)));
  }
+EXPORT_SYMBOL_GPL(dw_pcie_link_up_debug_check);
+
+bool dw_pcie_link_up(struct dw_pcie *pci)
+{
+       if (pci->ops && pci->ops->link_up)
+               return pci->ops->link_up(pci);
+
+       return dw_pcie_link_up_debug_check(pci);
+}
  EXPORT_SYMBOL_GPL(dw_pcie_link_up);

  void dw_pcie_upconfig_setup(struct dw_pcie *pci)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h 
b/drivers/pci/controller/dwc/pcie-designware.h
index 4199324882800..2ce61709b58c2 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -618,6 +618,7 @@ int dw_pcie_write(void __iomem *addr, int size, u32 
val);
  u32 dw_pcie_read_dbi(struct dw_pcie *pci, u32 reg, size_t size);
  void dw_pcie_write_dbi(struct dw_pcie *pci, u32 reg, size_t size, u32 
val);
  void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 
val);
+bool dw_pcie_link_up_debug_check(struct dw_pcie *pci);
  bool dw_pcie_link_up(struct dw_pcie *pci);
  void dw_pcie_upconfig_setup(struct dw_pcie *pci);
  int dw_pcie_wait_for_link(struct dw_pcie *pci);
diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c 
b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index dbc0115885afc..b2ed1a329c418 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -127,9 +127,7 @@ static bool rcar_gen4_pcie_link_up(struct dw_pcie *dw)
                 return false;

         /* The APP link-up events remain latched after the link goes 
down. */
-       val = dw_pcie_readl_dbi(dw, PORT_LINK_DEBUG1);
-       return (val & PORT_LINK_DEBUG1_LINK_UP) &&
-              !(val & PORT_LINK_DEBUG1_LINK_IN_TRAINING);
+       return dw_pcie_link_up_debug_check(dw);
  }

  /*
