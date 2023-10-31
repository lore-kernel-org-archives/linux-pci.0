Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8B3C4167D
	for <linux-pci@archiver.kernel.org>; Tue, 31 Oct 2023 17:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346187AbjJaRZk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 31 Oct 2023 13:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346801AbjJaRZj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Oct 2023 13:25:39 -0400
X-Greylist: delayed 3267 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 31 Oct 2023 10:25:36 PDT
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB53B92
        for <linux-pci@vger.kernel.org>; Tue, 31 Oct 2023 10:25:36 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 39VGOmMW007176;
        Tue, 31 Oct 2023 11:24:48 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 39VGOl1e007175;
        Tue, 31 Oct 2023 11:24:47 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 31 Oct 2023 11:24:47 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, linux-pci@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [pci:controller/xilinx-xdma] BUILD REGRESSION 8d786149d78c7784144c7179e25134b6530b714b
Message-ID: <20231031162447.GB19790@gate.crashing.org>
References: <202310282050.Y5D8ZPCw-lkp@intel.com> <20231031145600.GA9161@bhelgaas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031145600.GA9161@bhelgaas>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 31, 2023 at 09:56:00AM -0500, Bjorn Helgaas wrote:
> That said, the unused functions do look legit:
> 
> grackle_set_stg() is a static function and the only call is under
> "#if 0".

It is a static inline.  It is *normal* that that is uncalled.  It is
very similar to a macro that has no invocation.  The warning is
overeager.


Segher
