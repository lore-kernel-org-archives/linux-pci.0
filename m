Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:46773 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751348AbdJLOPt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Oct 2017 10:15:49 -0400
Received: by mail-wm0-f47.google.com with SMTP id m72so13636530wmc.1
        for <linux-pci@vger.kernel.org>; Thu, 12 Oct 2017 07:15:49 -0700 (PDT)
Date: Thu, 12 Oct 2017 16:15:48 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Steve Lin <steven.lin1@broadcom.com>
Cc: netdev@vger.kernel.org, jiri@mellanox.com, davem@davemloft.net,
        michael.chan@broadcom.com, linux-pci@vger.kernel.org,
        linville@tuxdriver.com, gospo@broadcom.com
Subject: Re: [RFC 1/3] devlink: Add config parameter get/set operations
Message-ID: <20171012141548.GE14672@nanopsycho>
References: <1507815262-33294-1-git-send-email-steven.lin1@broadcom.com>
 <1507815262-33294-2-git-send-email-steven.lin1@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1507815262-33294-2-git-send-email-steven.lin1@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thu, Oct 12, 2017 at 03:34:20PM CEST, steven.lin1@broadcom.com wrote:
>+
>+	/* When config doesn't take effect until next reboot (config
>+	 * just changed NVM which isn't read until boot, for example),
>+	 * this attribute should be set by the driver.
>+	 */
>+	DEVLINK_ATTR_RESTART_REQUIRED,		/* u8 */
>+

I think it would be nice to return this information as a part of retply
to set message - extack

Also, we need to expose to the user the original value (currently being
used) and the new one (to be used after driver re-instatiation)
