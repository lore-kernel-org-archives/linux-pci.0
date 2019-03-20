Return-Path: <SRS0=Ivhv=RX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D2AC43381
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 21:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38568218AE
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 21:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553116523;
	bh=j+E/RkT4UktfqqPBAngWwZyzd794VuSAqlhKXC2IEWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0bqmIer3N5W65RoP5LnaqRUkBM4lrOM7gEHeXSaahF5Mi6G5SpVdQ0r+ZFcLzIODv
	 IQ2VjtAIInBHH2GDSKO+7OEzwlHRwbuhaU89sL0IxzTsEeIg4EA7suXQo1tNyU2ITt
	 b4qxFNgK0guk02fU3Pl96kf6hi0yC3tC6k4PVaBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfCTVPW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Mar 2019 17:15:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727220AbfCTVPW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Mar 2019 17:15:22 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E4BA218AE;
        Wed, 20 Mar 2019 21:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553116520;
        bh=j+E/RkT4UktfqqPBAngWwZyzd794VuSAqlhKXC2IEWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C++4YfbK7ptX2duVbZsJuK8wxmYPn5fHlTyYxOLo6HfbxXiJCU/qWHqiNjrTqUYVW
         78saXUV0WzHvFgGHXHqGXuSOYL0Zvgme+f/r/QXzhgjIkC7EQuBufnQg5U7uzsclsD
         bAM0k2XzfTXLe3Dwoh+JCuLXrkREDSvTvbVYbpls=
Date:   Wed, 20 Mar 2019 16:15:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, kurt.schwemmer@microsemi.com,
        logang@deltatee.com, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>
Subject: Re: [PATCH v2] drivers: ntb: Kconfig: pedantic cleanups
Message-ID: <20190320211517.GG251185@google.com>
References: <1551898265-18909-1-git-send-email-info@metux.net>
 <1551909774-24030-1-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551909774-24030-1-git-send-email-info@metux.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Jon, Dave, Allen]

On Wed, Mar 06, 2019 at 11:02:54PM +0100, Enrico Weigelt, metux IT consult wrote:
> Formatting of Kconfig files doesn't look so pretty, so just
> take damp cloth and clean it up.

Oops, I didn't notice that this was a v2.  I first thought this was a
2/2 patch.  Sorry for the noise.  Most of my comments still apply
here, I think.

> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/ntb/Kconfig          | 20 ++++++++++----------
>  drivers/ntb/hw/amd/Kconfig   |  4 ++--
>  drivers/ntb/hw/idt/Kconfig   | 41 ++++++++++++++++++++---------------------
>  drivers/ntb/hw/intel/Kconfig |  4 ++--
>  drivers/ntb/hw/mscc/Kconfig  |  8 ++++----
>  drivers/ntb/test/Kconfig     | 26 +++++++++++++-------------
>  6 files changed, 51 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/ntb/Kconfig b/drivers/ntb/Kconfig
> index 95944e5..5ce3fdd 100644
> --- a/drivers/ntb/Kconfig
> +++ b/drivers/ntb/Kconfig
> @@ -2,13 +2,13 @@ menuconfig NTB
>  	tristate "Non-Transparent Bridge support"
>  	depends on PCI
>  	help
> -	 The PCI-E Non-transparent bridge hardware is a point-to-point PCI-E bus
> -	 connecting 2 systems.  When configured, writes to the device's PCI
> -	 mapped memory will be mirrored to a buffer on the remote system.  The
> -	 ntb Linux driver uses this point-to-point communication as a method to
> -	 transfer data from one system to the other.
> +	  The PCI-E Non-transparent bridge hardware is a point-to-point PCI-E bus
> +	  connecting 2 systems.  When configured, writes to the device's PCI
> +	  mapped memory will be mirrored to a buffer on the remote system.  The
> +	  ntb Linux driver uses this point-to-point communication as a method to
> +	  transfer data from one system to the other.
>  
> -	 If unsure, say N.
> +	  If unsure, say N.
>  
>  if NTB
>  
> @@ -19,10 +19,10 @@ source "drivers/ntb/test/Kconfig"
>  config NTB_TRANSPORT
>  	tristate "NTB Transport Client"
>  	help
> -	 This is a transport driver that enables connected systems to exchange
> -	 messages over the ntb hardware.  The transport exposes a queue pair api
> -	 to client drivers.
> +	  This is a transport driver that enables connected systems to exchange
> +	  messages over the ntb hardware.  The transport exposes a queue pair api
> +	  to client drivers.
>  
> -	 If unsure, say N.
> +	  If unsure, say N.
>  
>  endif # NTB
> diff --git a/drivers/ntb/hw/amd/Kconfig b/drivers/ntb/hw/amd/Kconfig
> index cfe903c..9a90f17 100644
> --- a/drivers/ntb/hw/amd/Kconfig
> +++ b/drivers/ntb/hw/amd/Kconfig
> @@ -2,6 +2,6 @@ config NTB_AMD
>  	tristate "AMD Non-Transparent Bridge support"
>  	depends on X86_64
>  	help
> -	 This driver supports AMD NTB on capable Zeppelin hardware.
> +	  This driver supports AMD NTB on capable Zeppelin hardware.
>  
> -	 If unsure, say N.
> +	  If unsure, say N.
> diff --git a/drivers/ntb/hw/idt/Kconfig b/drivers/ntb/hw/idt/Kconfig
> index f8948cf..5d106ac 100644
> --- a/drivers/ntb/hw/idt/Kconfig
> +++ b/drivers/ntb/hw/idt/Kconfig
> @@ -3,28 +3,27 @@ config NTB_IDT
>  	depends on PCI
>  	select HWMON
>  	help
> -	 This driver supports NTB of cappable IDT PCIe-switches.
> +	  This driver supports NTB of cappable IDT PCIe-switches.
>  
> -	 Some of the pre-initializations must be made before IDT PCIe-switch
> -	 exposes it NT-functions correctly. It should be done by either proper
> -	 initialisation of EEPROM connected to master smbus of the switch or
> -	 by BIOS using slave-SMBus interface changing corresponding registers
> -	 value. Evidently it must be done before PCI bus enumeration is
> -	 finished in Linux kernel.
> +	  Some of the pre-initializations must be made before IDT PCIe-switch
> +	  exposes it NT-functions correctly. It should be done by either proper
> +	  initialisation of EEPROM connected to master smbus of the switch or
> +	  by BIOS using slave-SMBus interface changing corresponding registers
> +	  value. Evidently it must be done before PCI bus enumeration is
> +	  finished in Linux kernel.
>  
> -	 First of all partitions must be activated and properly assigned to all
> -	 the ports with NT-functions intended to be activated (see SWPARTxCTL
> -	 and SWPORTxCTL registers). Then all NT-function BARs must be enabled
> -	 with chosen valid aperture. For memory windows related BARs the
> -	 aperture settings shall determine the maximum size of memory windows
> -	 accepted by a BAR. Note that BAR0 must map PCI configuration space
> -	 registers.
> +	  First of all partitions must be activated and properly assigned to all
> +	  the ports with NT-functions intended to be activated (see SWPARTxCTL
> +	  and SWPORTxCTL registers). Then all NT-function BARs must be enabled
> +	  with chosen valid aperture. For memory windows related BARs the
> +	  aperture settings shall determine the maximum size of memory windows
> +	  accepted by a BAR. Note that BAR0 must map PCI configuration space
> +	  registers.
>  
> -	 It's worth to note, that since a part of this driver relies on the
> -	 BAR settings of peer NT-functions, the BAR setups can't be done over
> -	 kernel PCI fixups. That's why the alternative pre-initialization
> -	 techniques like BIOS using SMBus interface or EEPROM should be
> -	 utilized.
> -
> -	 If unsure, say N.
> +	  It's worth to note, that since a part of this driver relies on the
> +	  BAR settings of peer NT-functions, the BAR setups can't be done over
> +	  kernel PCI fixups. That's why the alternative pre-initialization
> +	  techniques like BIOS using SMBus interface or EEPROM should be
> +	  utilized.
>  
> +	  If unsure, say N.
> diff --git a/drivers/ntb/hw/intel/Kconfig b/drivers/ntb/hw/intel/Kconfig
> index 91f995e..c166d50 100644
> --- a/drivers/ntb/hw/intel/Kconfig
> +++ b/drivers/ntb/hw/intel/Kconfig
> @@ -2,6 +2,6 @@ config NTB_INTEL
>  	tristate "Intel Non-Transparent Bridge support"
>  	depends on X86_64
>  	help
> -	 This driver supports Intel NTB on capable Xeon and Atom hardware.
> +	  This driver supports Intel NTB on capable Xeon and Atom hardware.
>  
> -	 If unsure, say N.
> +	  If unsure, say N.
> diff --git a/drivers/ntb/hw/mscc/Kconfig b/drivers/ntb/hw/mscc/Kconfig
> index 013ed67..74ec015 100644
> --- a/drivers/ntb/hw/mscc/Kconfig
> +++ b/drivers/ntb/hw/mscc/Kconfig
> @@ -2,8 +2,8 @@ config NTB_SWITCHTEC
>  	tristate "MicroSemi Switchtec Non-Transparent Bridge Support"
>  	select PCI_SW_SWITCHTEC
>  	help
> -	 Enables NTB support for Switchtec PCI switches. This also
> -	 selects the Switchtec management driver as they share the same
> -	 hardware interface.
> +	  Enables NTB support for Switchtec PCI switches. This also
> +	  selects the Switchtec management driver as they share the same
> +	  hardware interface.
>  
> -	 If unsure, say N.
> +	  If unsure, say N.
> diff --git a/drivers/ntb/test/Kconfig b/drivers/ntb/test/Kconfig
> index a5d0eda..416ab56 100644
> --- a/drivers/ntb/test/Kconfig
> +++ b/drivers/ntb/test/Kconfig
> @@ -1,27 +1,27 @@
>  config NTB_PINGPONG
>  	tristate "NTB Ping Pong Test Client"
>  	help
> -	 This is a simple ping pong driver that exercises the scratchpads and
> -	 doorbells of the ntb hardware.  This driver may be used to test that
> -	 your ntb hardware and drivers are functioning at a basic level.
> +	  This is a simple ping pong driver that exercises the scratchpads and
> +	  doorbells of the ntb hardware.  This driver may be used to test that
> +	  your ntb hardware and drivers are functioning at a basic level.
>  
> -	 If unsure, say N.
> +	  If unsure, say N.
>  
>  config NTB_TOOL
>  	tristate "NTB Debugging Tool Test Client"
>  	help
> -	 This is a simple debugging driver that enables the doorbell and
> -	 scratchpad registers to be read and written from the debugfs.  This
> -	 enables more complicated debugging to be scripted from user space.
> -	 This driver may be used to test that your ntb hardware and drivers are
> -	 functioning at a basic level.
> +	  This is a simple debugging driver that enables the doorbell and
> +	  scratchpad registers to be read and written from the debugfs.  This
> +	  enables more complicated debugging to be scripted from user space.
> +	  This driver may be used to test that your ntb hardware and drivers are
> +	  functioning at a basic level.
>  
> -	 If unsure, say N.
> +	  If unsure, say N.
>  
>  config NTB_PERF
>  	tristate "NTB RAW Perf Measuring Tool"
>  	help
> -	 This is a tool to measure raw NTB performance by transferring data
> -	 to and from the window without additional software interaction.
> +	  This is a tool to measure raw NTB performance by transferring data
> +	  to and from the window without additional software interaction.
>  
> -	 If unsure, say N.
> +	  If unsure, say N.
> -- 
> 1.9.1
> 
