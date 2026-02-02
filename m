Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DD71ADC83;
	Mon,  2 Feb 2026 09:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770024438; cv=none; b=tCThru9Tl6nx9UY2CIAR4SlQPOf9Vmc0hsqo9hnRIP3wyYtwFMG06BobuhxtBd8Scb8bUCSwe+rwDbdjfmC0TShVHtPusfBNMcz0NJ9mF0H2vROPSUpRbrZitvOtmTkvZiNMjCRcR3B+7dvTDSZyhWIMsocy5cby2J7B39nIrC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770024438; c=relaxed/simple;
	bh=b3tm47c8YeCLtBZmLUWotU+9f5TDfFlSjYMnR48dl5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HB32tY8qeqR/Abn3j36BPdSANzRSJse75FbUGLV2GF53Pd+y7EZPfpZg6V1RdSaafrU05Hm9F2hpoZ+SheYQyc5PgiSXREPPNjZCkuQwganE+Kc6lGJN7TJ43FxiBVSNCklTojbkS0HpUTMeOK6aDq+DKdD3aSWUaI16nJyt3Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFW8nI/d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFW8nI/d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1E0C116C6;
	Mon,  2 Feb 2026 09:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770024437;
	bh=b3tm47c8YeCLtBZmLUWotU+9f5TDfFlSjYMnR48dl5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DFW8nI/dKocoLcIkta4LQ0jKncQEMXXqK8dsPW2CWWdcPD6wN6EpbZy0fiZPfKO8b
	 TnG6E3qy5ZYdXeJmPDb7Nb57FhDSsS7GgHG4mbhOXmrjOZW63d6p7fJY78hQAGSfBE
	 wvqd9lsH3KW0ZHzwaSWaCKsuwvGRZHaz841b95pmMfozYy9a2leuPvIVl5AKHSApwY
	 RBZplcBwUv2YNzBSiQU5JChAgtsKxXkDXcsyQYNY7efK3f6TfehhURMozbltAd+SfV
	 kL4J968NGJPBOUq+w9DjKFk4DYrQVOBGzEzg1XNqdZHOBgbkQBbn0sLfQjKkvDeL02
	 +eXGVw5Vop1gQ==
Date: Mon, 2 Feb 2026 10:27:12 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, corbet@lwn.net, jingoohan1@gmail.com,
	lpieralisi@kernel.org, robh@kernel.org, Frank.Li@nxp.com,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: endpoint: Document pci_epc_set_bar() caller
 ownership and lifetime rules
Message-ID: <aYBt8OSLKC6F3nZG@ryzen>
References: <20260131133655.218018-1-den@valinux.co.jp>
 <20260131133655.218018-4-den@valinux.co.jp>
 <aX4y3txKcYmb-kE3@fedora>
 <4erlj426nvmilwfdq5e63ojiqecomcpj35nvmiyw2p5mvifwlt@yspmfxrzmxei>
 <aX_HfpBoQX4j7mag@ryzen>
 <sextbnbmsur2xjfoun2l4lr5vekmpzae7sx6or2ird44t6ud6d@yprcz43tpq4p>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sextbnbmsur2xjfoun2l4lr5vekmpzae7sx6or2ird44t6ud6d@yprcz43tpq4p>

On Mon, Feb 02, 2026 at 02:59:35PM +0900, Koichiro Den wrote:
> > 
> > Considering that struct pci_epf_bar lives in struct pci_epf, I think my
> > previous idea of doing a kmemdup, seems wrong...
> > 
> 
> I don't think it's inherently wrong. I think it really comes down to what
> contract we want pci_epc_set_bar() to imply.
> 
> When I saw your earlier comment:
> https://lore.kernel.org/all/aX019VTWjMlPX8qp@fedora/
> I hastily assumed you were implicitly suggesting that there are some
> outliers (such as epf-vntb), which led me to think we should document a
> single "legit" way to use the API. In hindsight, I read too much into it,
> there doesn't seem to be a clearly established contract today.
> 
> One subtlety if we decide to treat in-place updates as supported: the
> existing dynamic update compatibility check in dwc [3] becomes officially
> best-effort, because ep->epf_bar[bar] and the passed-in epf_bar may point
> to the same object (so comparing against the previous state is not
> reliable). In other words, changing barno/size/flags via in-place updates
> would be caller misuse, but the driver cannot always detect it.

Yes, I agree, but I think that is fine.

If the caller does a fundamental change to an existing struct pci_epf_bar,
between two set_bar() calls... they have no one to blame but themselves.

At least the check will be able to detect when the second set_bar() call
is supplied a new struct which does not have the same size / flags as the
struct pci_epf_bar that is currently in use.

The same currently applies to clear_bar():
If you do a stupid in place update of the struct pci_epf_bar after calling
set_bar(), e.g. modifying epf_bar->barno, clear_bar() will absolutely do
"bad things".

Perhaps we should update the comment in dw_pcie_ep_set_bar():

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 7e7844ff0f7e..451ba8add157 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -518,6 +518,11 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
                /*
                 * We can only dynamically change a BAR if the new BAR size and
                 * BAR flags do not differ from the existing configuration.
+                *
+                * Note: this safety check only works when the caller uses a new
+                * struct pci_epf_bar in the second set_bar() call. If the same
+                * struct pci_epf_bar was supplied (i.e. being updated in place)
+                * then it is impossible to detect invalid changes to the BAR.
                 */
                if (ep_func->epf_bar[bar]->barno != bar ||
                    ep_func->epf_bar[bar]->size != size ||


To make it clear that this safety check is not always possible.


> > I'm sorry for making you waste time. I did miss that even though pci-epf-vntb
> > does not do in place updates of doorbell BAR, it does so for the other BARs.
> 
> No worries at all, and thanks for digging through the history with me.
> At this point, I think there are still two reasonable options (to
> summarize):
> 
> X). Treat the existing in-tree callers (including in-place update) as valid
>     usage (i.e. apply [4]).
> 
>     [4] https://lore.kernel.org/linux-pci/q5e7ydmf4ra6x2mbxwifovgr6p6x5dfnz3hz5psq5ypyabtsvx@oq5ovi4o26yf/
> 
>     In this case, the downside noted in [4] remains: if a BAR reprogramming
>     attempt fails (especially for the long-standing epf-vntb's BAR Match ->
>     BAR Match transition case), the previously programmed inbound mapping
>     will already have been torn down. This behavior change is inherent in
>     making the teardown unconditional. I think this is acceptable because
>     if the caller is passing incompatible/invalid parameters, things are
>     already going off the rails anyway, and the call site that receives the
>     error should never actively use the BAR for any real transactions.
> 
>     Separately, if we treat in-place updates as supported, some of the
>     existing compatibility checks (e.g. barno/size/flags) become inherently
>     best-effort, because the previous state may no longer be observable by
>     the driver. Addressing that would require additional follow-up work
>     (e.g. with doing a kmemdup and holding the snapshot), but this is a
>     pre-existing issue, so there is no need to rush fixing this.
> 
> Y). Define a stricter API usage contract, document it, and then adjust all
>     the caller sides later (i.e. apply this v2 series).
> 
>     The downside here is that struct pci_epf embeds the struct pci_epf_bar
>     array, so tightening the contract and fixing existing users would
>     likely be awkward.
> 
> Personally, I'm inclined towards (X) at the moment, mainly because there
> doesn't seem to be a firm, shared understanding of the API contract today.
> Later, we can do follow-up work for the existing behaviour, which is
> already present on mainline.
> 
> If you still agree with (X), I'll send v2 with splitting [4] into two-patch
> series, with an explanation above the unconditional
> dw_pcie_ep_clear_ib_maps().

I did not change my mind a second time :)

So I still think X is the way to go.


Kind regards,
Niklas
