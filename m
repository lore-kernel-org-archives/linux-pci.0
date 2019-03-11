Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75A5C43381
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 13:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A833422314
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 13:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552311199;
	bh=FzmBTOYv3DlKkw61iNl06+QFZGEZ/z0t+KzY4FZ4t9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SaBlA1N9riXd5MzIU9V+34zPhfC/PUhpQch0DHW/4Dssci10wvcNJpC+T1YsDi1zD
	 z3V+Du42+nz3y22m6Yjg8OM4cJpnj3aCHbYGgyvYlc/PElPGro0vh1UyzWtJcsHdey
	 Bbv1H3pu3cC/a7ehDCXXg/Y/0cqsDCLLfOLznPbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfCKNdN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:33:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727426AbfCKNdN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 09:33:13 -0400
Received: from localhost (50-82-46-41.client.mchsi.com [50.82.46.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF0B72147A;
        Mon, 11 Mar 2019 13:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552311192;
        bh=FzmBTOYv3DlKkw61iNl06+QFZGEZ/z0t+KzY4FZ4t9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ReQmeHrkseghdTjlSkOu1EECP2CkfqlBDPPSFpSrpilimTMMH9sILYbsS+MyU633o
         1xW4v1S5TCO/7Ce863cZKH2YvO1EZY1RLgTjjOG1wOW5DdcuVFPrwsu2ZqgYVpsVgL
         JwhQwyDlrHMPoVYjxFx2x251z39eWTJ+U56NSCbE=
Date:   Mon, 11 Mar 2019 08:33:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>
Subject: Re: [PATCHv4 00/28] PCI: refactor Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
Message-ID: <20190311133310.GE214730@google.com>
References: <20190311093130.7209-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311093130.7209-1-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Mon, Mar 11, 2019 at 09:29:54AM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> This patch set is aim to refactor the Mobiveil driver and add
> PCIe support for NXP Layerscape series SoCs integrated Mobiveil's
> PCIe Gen4 controller.
> 
> Hou Zhiqiang (28):
>   PCI: mobiveil: uniform the register accessors

"uniform" is not a verb.  Maybe "Unify register accessors"?

>   PCI: mobiveil: format the code without function change
>   PCI: mobiveil: correct the returned error number
>   PCI: mobiveil: remove flag MSI_FLAG_MULTI_PCI_MSI
>   PCI: mobiveil: correct PCI base address in MEM/IO outbound windows
>   PCI: mobiveil: replace the resource list iteration function
>   PCI: mobiveil: use WIN_NUM_0 explicitly for CFG outbound window
>   PCI: mobiveil: use the 1st inbound window for MEM inbound transactions
>   PCI: mobiveil: correct inbound/outbound window setup routines
>   PCI: mobiveil: fix the INTx process error
>   PCI: mobiveil: only fix up the Class Code field
>   PCI: mobiveil: move out the link up waiting from mobiveil_host_init

Add parens for function names, e.g., "mobiveil_host_init()".  This
occurs several more times, including both subject lines and changelogs.

>   PCI: mobiveil: move irq chained handler setup out of DT parse

Capitalize acronyms in English text (subject lines, changelogs,
comments), e.g., s/irq/IRQ/

>   PCI: mobiveil: initialize Primary/Secondary/Subordinate bus number
>   dt-bindings: pci: mobiveil: change gpio_slave and apb_csr to optional
>   PCI: mobiveil: refactor Mobiveil PCIe Host Bridge IP driver

This should give a hint about the purpose of refactoring.  Sounds like
it's to make it easier to support both host and endpoint mode?

>   PCI: mobiveil: fix the checking of valid device
>   PCI: mobiveil: add link up condition check
>   PCI: mobiveil: continue to initialize the host upon no PCIe link
>   PCI: mobiveil: disabled IB and OB windows set by bootloader
>   PCI: mobiveil: add Byte and Half-Word width register accessors

"Byte" and "Half-Word" do not need to be capitalized.  Also, the
changelog has a typo: "Half-Work" for "half-word".

>   PCI: mobiveil: make mobiveil_host_init can be used to re-init host

Here's another of the places that need parens after the function name.

>   dt-bindings: pci: Add NXP Layerscape SoCs PCIe Gen4 controller
>   PCI: mobiveil: add PCIe Gen4 RC driver for NXP Layerscape SoCs
>   PCI: mobiveil: ls_pcie_g4: add Workaround for A-011577
>   PCI: mobiveil: ls_pcie_g4: add Workaround for A-011451

The reader of these changelogs likely doesn't know what internal
identifiers like "A-011577" mean, but *does* want a hint about what
problem is being fixed and what platforms are affected.  So instead of
the "ls_pcie_g4:" prefix, use something like:

  PCI: mobiveil: Work around LX2160A r1.0 config access erratum
  PCI: mobiveil: Work around LX2160A r1.0 split completion erratum

and mention the erratum ID (A-011577) in the changelog.  If you can
include the actual erratum text in the changelog, that would be even
better.

s/ERRATA/errata/ in the changelogs.

>   arm64: dts: freescale: lx2160a: add pcie DT nodes

"PCIe"

>   arm64: defconfig: Enable CONFIG_PCI_LAYERSCAPE_GEN4

I already asked you once [1] to:

  please pay attention to the changelog conventions, e.g., capitalize the
  first word of the sentence ("Remove flag ...", "Correct PCI base address
  ...", etc), capitalize acronyms like "PCI" and "IRQ", use parentheses
  after function names, etc.  You can see the conventions by running "git
  log --oneline drivers/pci/controller".

For example, instead of this:

  PCI: mobiveil: add link up condition check

it should be this:

  PCI: mobiveil: Add link up condition check

Please wait at least a few days before posting a v5 in case there are
other comments.

Bjorn

[1] https://lore.kernel.org/linux-pci/20190130153447.GB229773@google.com
