Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39044 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754241AbcEBRab (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 2 May 2016 13:30:31 -0400
Date: Mon, 2 May 2016 12:30:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andreas Noever <andreas.noever@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>, stable@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Fix double free of drom buffer
Message-ID: <20160502173026.GF24851@localhost>
References: <1460285307-3557-1-git-send-email-andreas.noever@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1460285307-3557-1-git-send-email-andreas.noever@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Apr 10, 2016 at 12:48:27PM +0200, Andreas Noever wrote:
> If tb_drom_read fails sw->drom is freed but not set to NULL. sw->drom
> is then freed again in the error path of sw_switch_alloc.

s/sw_switch_alloc/tb_switch_alloc/ ?

> The bug can be triggered by unplugging a thunderbolt device shortly
> after it is detected by the thunderbolt driver.
> 
> Signed-off-by: Andreas Noever <andreas.noever@gmail.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org

How far back would this need to be applied?  What is the commit where
the but was introduced?

I applied this to pci/thunderbolt for v4.7 with the following
changelog.  If I did it wrong, I'll gladly update it, especially if
you have specific symptoms of a bug or oops that would help people
find this fix.

    thunderbolt: Fix double free of drom buffer
    
    If tb_drom_read() fails, sw->drom is freed but not set to NULL.  sw->drom
    is then freed again in the error path of tb_switch_alloc().
    
    The bug can be triggered by unplugging a thunderbolt device shortly after
    it is detected by the thunderbolt driver.
    
    Clear sw->drom if tb_drom_read() fails.
    
    [bhelgaas: add Fixes:, stable versions of interest]
    Fixes: 343fcb8c70d7 ("thunderbolt: Fix nontrivial endpoint devices.")
    Signed-off-by: Andreas Noever <andreas.noever@gmail.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    CC: stable@vger.kernel.org	# v3.17+
    CC: Lukas Wunner <lukas@wunner.de>

> ---
>  drivers/thunderbolt/eeprom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/thunderbolt/eeprom.c b/drivers/thunderbolt/eeprom.c
> index 0dde34e..545c60c 100644
> --- a/drivers/thunderbolt/eeprom.c
> +++ b/drivers/thunderbolt/eeprom.c
> @@ -444,6 +444,7 @@ int tb_drom_read(struct tb_switch *sw)
>  	return tb_drom_parse_entries(sw);
>  err:
>  	kfree(sw->drom);
> +	sw->drom = NULL;
>  	return -EIO;
>  
>  }
> -- 
> 2.8.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
