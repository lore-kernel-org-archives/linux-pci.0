Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4BFC4167B
	for <linux-pci@archiver.kernel.org>; Tue, 31 Oct 2023 14:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbjJaO4H (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 31 Oct 2023 10:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjJaO4G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Oct 2023 10:56:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5532A101
        for <linux-pci@vger.kernel.org>; Tue, 31 Oct 2023 07:56:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1EF5C433C7;
        Tue, 31 Oct 2023 14:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698764162;
        bh=Cxdgq83jiMoJ70NysJNU4kcpJnjm2mFKYjiQrvsOqUQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Jog2dxcMmGGGRASrapDOhOj8zcOAieXrt9M+dygNz7EEFwueTaWid3idU+e4dvxSS
         t1f3nvl2Xw/eDzoVtpUWnuRZsugYFVvFiXd7LhhFiJjbo5w3uZ8erqzsbZGA8i2hfZ
         irEX+TgbAk6CmRjYTxjsoFZ1kTYwoGd55+uaLinwBYIj2Q8SQqAUBI2N93hIRyulpw
         mkSQ8QtRFnyTjHF2Wzf3qNdgwT+GjCUfPZssWyEpD28aTw2tD/fM4PWNLWfygZUgpr
         bKIiavOsnkyE1cb0yoF3pZdMva1irDxt+WcHoLWdfZfTCb6ALlcGiCRkSwS/MO5yjD
         WG4cRXU75oC9Q==
Date:   Tue, 31 Oct 2023 09:56:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        linux-pci@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [pci:controller/xilinx-xdma] BUILD REGRESSION
 8d786149d78c7784144c7179e25134b6530b714b
Message-ID: <20231031145600.GA9161@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310282050.Y5D8ZPCw-lkp@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc powerpc, clang folks]

On Sat, Oct 28, 2023 at 08:22:54PM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/xilinx-xdma
> branch HEAD: 8d786149d78c7784144c7179e25134b6530b714b  PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver
> 
> Error/Warning ids grouped by kconfigs:
> 
> clang_recent_errors
> `-- powerpc-pmac32_defconfig
>     |-- arch-powerpc-sysdev-grackle.c:error:unused-function-grackle_set_stg-Werror-Wunused-function
>     |-- arch-powerpc-xmon-xmon.c:error:unused-function-get_output_lock-Werror-Wunused-function
>     `-- arch-powerpc-xmon-xmon.c:error:unused-function-release_output_lock-Werror-Wunused-function

This report is close to useless.  It doesn't show the complete error
message, it doesn't show how to reproduce the issue, and the pci -next
branch (including controller/xilinx-xdma) doesn't reference any of
these functions:

  $ git grep -E "grackle_set_stg|get_output_lock|release_output_lock" | cat
  arch/powerpc/sysdev/grackle.c:static inline void grackle_set_stg(struct pci_controller* bp, int enable)
  arch/powerpc/sysdev/grackle.c:	grackle_set_stg(hose, 1);
  arch/powerpc/xmon/xmon.c:static void get_output_lock(void)
  arch/powerpc/xmon/xmon.c:static void release_output_lock(void)
  arch/powerpc/xmon/xmon.c:static inline void get_output_lock(void) {}
  arch/powerpc/xmon/xmon.c:static inline void release_output_lock(void) {}
  arch/powerpc/xmon/xmon.c:		get_output_lock();
  arch/powerpc/xmon/xmon.c:		release_output_lock();
  arch/powerpc/xmon/xmon.c:			get_output_lock();
  arch/powerpc/xmon/xmon.c:			release_output_lock();
  arch/powerpc/xmon/xmon.c:		get_output_lock();
  arch/powerpc/xmon/xmon.c:		release_output_lock();
  arch/powerpc/xmon/xmon.c:		get_output_lock();
  arch/powerpc/xmon/xmon.c:		release_output_lock();

That said, the unused functions do look legit:

grackle_set_stg() is a static function and the only call is under
"#if 0".

Same with get_output_lock() and release_output_lock(): they're static
and always defined in xmon.c, but only called if either CONFIG_SMP or
CONFIG_DEBUG_FS.

But they're certainly not related to controller/xilinx-xdma, so I'm
going to ignore them.

Bjorn

P.S. Nathan & Nick, I cc'd you because of this earlier report that
also mentioned grackle_set_stg():
https://lore.kernel.org/lkml/202308121120.u2d3YPVt-lkp@intel.com/
