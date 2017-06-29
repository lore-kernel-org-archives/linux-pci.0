Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from esa2.dell-outbound.iphmx.com ([68.232.149.220]:19953 "EHLO
        esa2.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753351AbdF2SM1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jun 2017 14:12:27 -0400
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
To: "'Logan Gunthorpe'" <logang@deltatee.com>,
        <linux-ntb@googlegroups.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Cc: "'Jon Mason'" <jdmason@kudzu.us>,
        "'Dave Jiang'" <dave.jiang@intel.com>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Kurt Schwemmer'" <kurt.schwemmer@microsemi.com>,
        "'Stephen Bates'" <sbates@raithlin.com>,
        "'Serge Semin'" <fancer.lancer@gmail.com>
References: <20170629032648.3073-1-logang@deltatee.com> <20170629032648.3073-7-logang@deltatee.com>
In-Reply-To: <20170629032648.3073-7-logang@deltatee.com>
Subject: RE: [PATCH 06/16] ntb: add check and comment for link up to mw_count and mw_get_align
Date: Thu, 29 Jun 2017 14:11:56 -0400
Message-ID: <000301d2f103$3310ca60$99325f20$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Logan Gunthorpe
> This patch adds a comment and a check to the ntb_mw_get_align and
> ntb_mw_count functions so that they always fail if the function is
> called before the link is up.
>=20
> This is to prevent accidental mis-use in clients that are testing
> on hardware that this doesn't matter for.
>=20
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Nak.  This breaks a work around for stability issues on some hardware.  =
I am ok with changing the comment to say, this is only supported when =
called after link up.  I would still like to allow these to be called at =
any time.  Specific hardware drivers like Switchtec may return an error. =
 Upstream drivers, of course, should call these after link up: patch =
5/16 part of this set looks good.

> ---
>  include/linux/ntb.h | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/ntb.h b/include/linux/ntb.h
> index 609e232c00da..de4f800c82b6 100644
> --- a/include/linux/ntb.h
> +++ b/include/linux/ntb.h
> @@ -730,12 +730,16 @@ static inline int ntb_link_disable(struct =
ntb_dev *ntb)
>   * Hardware and topology may support a different number of memory =
windows.
>   * Moreover different peer devices can support different number of =
memory
>   * windows. Simply speaking this method returns the number of =
possible inbound
> - * memory windows to share with specified peer device.
> + * memory windows to share with specified peer device. Note: this =
must only be
> + * called when the link is up.
>   *
>   * Return: the number of memory windows.
>   */
>  static inline int ntb_mw_count(struct ntb_dev *ntb, int pidx)
>  {
> +	if (!(ntb_link_is_up(ntb, NULL, NULL) & (1 << pidx)))
> +		return 0;
> +
>  	return ntb->ops->mw_count(ntb, pidx);
>  }
>=20
> @@ -751,7 +755,7 @@ static inline int ntb_mw_count(struct ntb_dev =
*ntb, int pidx)
>   * Get the alignments of an inbound memory window with specified =
index.
>   * NULL may be given for any output parameter if the value is not =
needed.
>   * The alignment and size parameters may be used for allocation of =
proper
> - * shared memory.
> + * shared memory. Note: this must only be called when the link is up.
>   *
>   * Return: Zero on success, otherwise a negative error number.
>   */
> @@ -760,6 +764,9 @@ static inline int ntb_mw_get_align(struct ntb_dev =
*ntb, int pidx, int widx,
>  				   resource_size_t *size_align,
>  				   resource_size_t *size_max)
>  {
> +	if (!(ntb_link_is_up(ntb, NULL, NULL) & (1 << pidx)))
> +		return -ENOTCONN;
> +
>  	return ntb->ops->mw_get_align(ntb, pidx, widx, addr_align, =
size_align,
>  				      size_max);
>  }
> --
> 2.11.0
