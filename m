Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA28BCD37B0
	for <linux-pci@archiver.kernel.org>; Mon, 18 Sep 2023 07:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjIRHBa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Sep 2023 03:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239994AbjIRHBO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Sep 2023 03:01:14 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0177BA
        for <linux-pci@vger.kernel.org>; Mon, 18 Sep 2023 00:01:07 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id A1EAB10308A08;
        Mon, 18 Sep 2023 09:01:05 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 71E9178781; Mon, 18 Sep 2023 09:01:05 +0200 (CEST)
Date:   Mon, 18 Sep 2023 09:01:05 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        iain@orangesquash.org.uk,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v19 2/2] PCI: Add a quirk for AMD PCIe root ports w/ USB4
 controllers
Message-ID: <20230918070105.GA20097@wunner.de>
References: <20230916133650.GA26241@wunner.de>
 <20230917214015.GA171862@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230917214015.GA171862@bhelgaas>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 17, 2023 at 04:40:15PM -0500, Bjorn Helgaas wrote:
> On Sat, Sep 16, 2023 at 03:36:50PM +0200, Lukas Wunner wrote:
> > The "pcie_find_root_port(child) != pdev" check is always false:
> 
> If we were using pci_walk_bus() and only looking at devices below
> pdev, I would agree, but since we're using pci_get_class(), which
> searches all PCI devices in the system, I'm confused about why it
> would always be false.

Right, I had misread the patch, I indeed thought it was using
pci_walk_bus().  My apologies for the noise.

(I guess I assumed that because a global search (as done here)
is more expensive than just searching below the Root Port.)

Thanks,

Lukas
