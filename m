Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A40306B08;
	Tue, 25 Aug 2026 02:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787626703; cv=none; b=EerrwXv0xp71hiUMyQwRfgPCDArxlTGG0WpitXGK77TnRf/fk6o+RAPCt0Yz42DbOSuY445YKxBwd3sRbqhqupHTNeftYtDL8hxt7+paQi43yFyuUK2RD+nfv6ei47wzzRjap20Zq3wmBbKIeVMlDQlQnOuW3pV9G72WefVU4mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787626703; c=relaxed/simple;
	bh=f/F6uANxyfdP5SwYsvNVcUcuuKdvcjOHmTUDDjy3eLs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L4uGW1CKO+Eb/0oQh8msBr5Tl8TOpbHQPZT0ubVmeNtDZ3AwxJzlXEHK5uS5Vjjo2AMaf7s4s77PnUh0hebtr5VAGs3ABvWq02hTGv4DR77kPbiLFfiTq8pRhw1FtiddLxGbumEzIYF1QgLLLj17CHPpYQpR70EbdawgBKo8l48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxCdRKta; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxCdRKta"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D911F000E9;
	Tue, 25 Aug 2026 02:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787626701;
	bh=BaFssKMupJ4dzjR2/rmeHFKw6Wn+RHQGdpWK+KYlQxA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lxCdRKtaq0iK1O57tRqqq7Mk9TwABF8lY1lNeth70Bcbu1GQNgyt8Tbs1dhpJOFFx
	 Rhl6OxCn0fnv/nsYjCgd4z4wAJ4lVxnrEZ/6sY1ybUUbQ0phh4xlY2MsX1dj0atMkA
	 iAHt8+FUCnshKMOdRTS/Cx6Y2DJtyapLfMRl5F1GbaNR74UEJuvpZ2xM9MRvbbJLHy
	 TgZcITzGOpR6igRM8PYBAzOVJQVBCLxk7teBI8Lyz8XQq5jaqrMvD/GJGclXtmRX1m
	 2w9foeoqMBpiwXe7uBvT60JmOCKKIOBh9In1RbGlqMqC1YTLNXkvMV9V7vCJzbHc4T
	 ITH3u2WpoTcjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/13] cxl/hdm: Reprogram the HDM Decoders below a
 CXL Port
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260825022628.3651434-5-fabio.m.de.francesco@linux.intel.com>
References: <20260825022628.3651434-1-fabio.m.de.francesco@linux.intel.com>
 <20260825022628.3651434-5-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 02:58:20 +0000
Message-Id: <20260825025821.06D911F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Valid ports intentionally lacking HDM decoder state (e.g., DVSEC e=
ndpoints or passthrough switches) incorrectly trigger an error that aborts =
topology restoration.
- [High] The HDM Decoder Global Control register is saved for all ports but=
 is only written back for endpoints, leaving switch HDM decoding globally d=
isabled.
- [High] Lockless iteration over `port->endpoints` using `xa_for_each()` le=
ads to a Use-After-Free of `struct cxl_ep` when endpoints are concurrently =
removed.
- [High] Lockless access to `iter->dev` driver data leads to Use-After-Free=
 of `struct cxl_hdm` if the port driver is concurrently unbound.
- [Medium] Recommitting decoders on shared switches during a per-endpoint p=
ath walk prematurely commits sibling decoders, violating the bottom-up prog=
ramming requirement.
--

--- Patch [4]: [PATCH v2 04/13] cxl/hdm: Reprogram the HDM Decoders below a=
 CXL Port ---
commit 8ab001ee7d558b0995b7f0cff3266fb8cd0949bb
Author: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

cxl/hdm: Reprogram the HDM Decoders below a CXL Port

A reset of a CXL Port clears the HDM Decoders of every component below it,
so the decode has to be put back for every endpoint the Port routes to.
This patch adds cxl_port_recommit_decoders() and cxl_port_save_hdm_state()
to save and restore HDM decoder states across a reset.

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 7c898c60f60f6..9839d2592d206 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
[ ... ]
> @@ -935,6 +935,42 @@ static bool cxl_endpoint_decoders_are_emulated(struc=
t cxl_port *endpoint)
>  				     __cxl_endpoint_decoder_is_emulated);
>  }
> =20
> +struct cxl_recommit_ctx {
> +	const struct cxl_hdm_state *state;
> +	int *first_rc;
> +};
> +
> +static int __cxl_port_recommit_decoder(struct device *dev, void *data)
> +{
> +	struct cxl_recommit_ctx *ctx =3D data;
> +	struct cxl_decoder *cxld;
> +	int rc;
> +
> +	if (!(is_switch_decoder(dev) || is_endpoint_decoder(dev)))
> +		return 0;
> +
> +	cxld =3D to_cxl_decoder(dev);
> +
> +	if (cxld->id >=3D ctx->state->nr_ctrl) {
> +		dev_warn(&cxld->dev, "%s: no saved control register\n",
> +			 __func__);
> +		if (!*ctx->first_rc)
> +			*ctx->first_rc =3D -ENODATA;
> +		return 0;
> +	}
> +
> +	/*
> +	 * Reprogram every decoder the walk reaches. Stopping at the first
> +	 * failure would leave the rest of the path decoding nothing, so record
> +	 * the first error and continue.
> +	 */
> +	rc =3D cxl_decoder_recommit(cxld, ctx->state->ctrl[cxld->id]);

[Severity: Medium]
Since this function is called for every child decoder of a switch port,
could it unconditionally recommit sibling decoders before their downstream
path is reprogrammed?

If multiple endpoints route through a shared switch, reprogramming the
switch during the first endpoint's traversal might commit decoders for
other endpoints whose downstream paths haven't been restored yet,
violating bottom-up programming requirements.

> +	if (rc && !*ctx->first_rc)
> +		*ctx->first_rc =3D rc;
> +
> +	return 0;
> +}
[ ... ]
> +int cxl_port_recommit_decoders(struct cxl_port *port, struct xarray *hdm=
_state)
> +{
> +	struct cxl_ep *port_ep;
> +	unsigned long index;
> +	int first_rc =3D 0;
> +
> +	lockdep_assert_held(&cxl_rwsem.region);
> +
> +	xa_for_each(&port->endpoints, index, port_ep) {

[Severity: High]
Does this lockless iteration risk a use-after-free of port_ep?

If a concurrent unbind of a cxl_mem driver invokes cxl_detach_ep(), the
endpoint is removed from the xarray and the struct cxl_ep is freed without
an RCU grace period. Since xa_for_each() doesn't hold the RCU read lock
across the loop body, port_ep could be freed before dereferencing
port_ep->ep.

> +		struct cxl_memdev *cxlmd =3D to_cxl_memdev(port_ep->ep);
> +		struct cxl_hdm_state *state;
> +		struct cxl_port *iter;
> +		int rc;
> +
> +		if (IS_ERR_OR_NULL(cxlmd->endpoint))
> +			continue;
> +
> +		state =3D xa_load(hdm_state, (unsigned long)cxlmd->endpoint);
> +		if (!state) {
> +			dev_warn(&cxlmd->dev, "%s: no saved HDM state\n",
> +				 __func__);
> +			if (!first_rc)
> +				first_rc =3D -ENODATA;
> +			continue;

[Severity: High]
If a valid port intentionally lacks HDM decoder state (e.g., a DVSEC endpoi=
nt
or passthrough switch), will this skip processing its upstream path?

This skip appears to completely abort topology restoration for the upstream
path when legitimately missing HDM state is encountered.

> +		}
> +
> +		rc =3D cxl_endpoint_enable_hdm_decode(cxlmd, state->global_ctrl);
> +		if (rc) {
> +			dev_warn(&cxlmd->dev,
> +				 "%s: failed to enable HDM decode: %d\n",
> +				 __func__, rc);
> +			if (!first_rc)
> +				first_rc =3D rc;
> +			continue;
> +		}
> +
> +		/*
> +		 * Walk from the endpoint up to @port so a decoder is committed
> +		 * only after the decoder it routes to. @port is the last parent
> +		 * visited by the walk, and it is excluded.
> +		 */
> +		for (iter =3D cxlmd->endpoint; iter && iter !=3D port;
> +		     iter =3D parent_port_of(iter)) {

[Severity: High]
Does this loop miss restoring the HDM Decoder Global Control register for
switch ports?

While cxl_endpoint_enable_hdm_decode() writes state->global_ctrl for endpoi=
nts,
this upstream walk only restores Decoder N Control registers for switch por=
ts
via __cxl_port_recommit_decoder(). The Global Control register for switches
is saved but never seems to be written back, leaving switch HDM decoding
globally disabled.

> +			struct cxl_recommit_ctx ctx =3D {
> +				.state =3D xa_load(hdm_state, (unsigned long)iter),
> +				.first_rc =3D &first_rc,
> +			};
> +
> +			if (!ctx.state) {
> +				dev_warn(&iter->dev, "%s: no saved HDM state\n",
> +					 __func__);
> +				if (!first_rc)
> +					first_rc =3D -ENODATA;
> +				continue;

[Severity: High]
Similar to the endpoint check above, could this erroneously throw -ENODATA
and skip reprogramming if a valid passthrough switch legitimately lacks
HDM state?

> +			}
> +
> +			device_for_each_child(&iter->dev, &ctx,
> +					      __cxl_port_recommit_decoder);

[Severity: Medium]
As mentioned earlier, does this loop inherently break bottom-up ordering
rules on shared switches by recommitting all of the switch's decoders during
the first endpoint's traversal?

> +		}
> +	}
> +
> +	return first_rc;
> +}
[ ... ]
> +int cxl_port_save_hdm_state(struct cxl_port *port, struct xarray *hdm_st=
ate)
> +{
> +	struct cxl_ep *port_ep;
> +	unsigned long index;
> +
> +	lockdep_assert_held(&cxl_rwsem.region);
> +
> +	xa_for_each(&port->endpoints, index, port_ep) {

[Severity: High]
Does this have the same use-after-free risk for port_ep as the loop in
cxl_port_recommit_decoders()?

> +		struct cxl_memdev *cxlmd =3D to_cxl_memdev(port_ep->ep);
> +		struct cxl_port *iter;
> +
> +		if (IS_ERR_OR_NULL(cxlmd->endpoint))
> +			continue;
> +
> +		for (iter =3D cxlmd->endpoint; iter && iter !=3D port;
> +		     iter =3D parent_port_of(iter)) {
> +			struct cxl_hdm *cxlhdm =3D dev_get_drvdata(&iter->dev);

[Severity: High]
Could this result in a use-after-free of cxlhdm if the port driver is
concurrently unbound?

Accessing driver data via dev_get_drvdata() while holding only
cxl_rwsem.region doesn't block driver unbind. A concurrent unbind
could release the devres allocations, freeing struct cxl_hdm before its
members are accessed below.

> +			struct cxl_hdm_state *state;
> +			void __iomem *hdm;
> +			int rc;
> +
> +			if (xa_load(hdm_state, (unsigned long)iter))
> +				continue;
> +
> +			if (!cxlhdm || !cxlhdm->regs.hdm_decoder)
> +				continue;
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825022628.3651=
434-1-fabio.m.de.francesco@linux.intel.com?part=3D4
