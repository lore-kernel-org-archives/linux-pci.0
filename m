Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lb1-smtp-cloud6.xs4all.net ([194.109.24.24]:58981 "EHLO
	lb1-smtp-cloud6.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751569AbbEUJC3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 May 2015 05:02:29 -0400
Message-ID: <1432198946.21715.141.camel@x220>
Subject: Re: [PATCH 07/16] NTB Tool Client
From: Paul Bolle <pebolle@tiscali.nl>
To: Allen Hubbe <Allen.Hubbe@emc.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>
Date: Thu, 21 May 2015 11:02:26 +0200
In-Reply-To: <6d1c7067f7af16088849a628a5227b2d19085098.1432135632.git.Allen.Hubbe@emc.com>
References: <cover.1432135631.git.Allen.Hubbe@emc.com>
	 <6d1c7067f7af16088849a628a5227b2d19085098.1432135632.git.Allen.Hubbe@emc.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2015-05-20 at 11:41 -0400, Allen Hubbe wrote:
> --- a/drivers/ntb/test/Kconfig
> +++ b/drivers/ntb/test/Kconfig
> +config NTB_TOOL
> +       tristate "NTB Debugging Tool Client"
> +       depends on NTB

Same nit as for 2/16 and 7/16.

> +       help

> +        If unsure, say N.

(Please start the indentation with a tab, and not with spaces.)

Thanks,


Paul Bolle

