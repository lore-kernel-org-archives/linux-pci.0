Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3D13E4C6B;
	Fri, 11 Sep 2026 23:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789169465; cv=none; b=uCZBACcqydNVoeqYNFdZV96Z/L4j9Xn4gX70I7uEEI/3mhOoRqrp+bX7YgaG/4C0cO2kLHxvuH0fe8f2LL1BMcagx2SMioRMppzEq7LdS9RlqzKtGu1pLg+QDKkQlYU1f8yegaet9TS1fcMQSG/jCzWxxD7Rm0/dd5dRpYfJU9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789169465; c=relaxed/simple;
	bh=h8As0UFLjOQTu/3xtSV55nPGckng/olhZc5Iq5hZcXc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UWfT3mmdKgNhFiqSR6X9zkd9Ub7CFIcyMc4n+nB9La3vHKCeHHLtsHV7FFEW4QCngB3m6OBOmQ8Iv9a3adiMaKhNdn393r3DGSlSq1HHQkSTv3AomO/IPvF4D5depN9u+Jq4iE0odwuRCdREziylE4CDY3uWrz3Ftzi/q56YKBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TO53MoXF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TO53MoXF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CE71F000FF;
	Fri, 11 Sep 2026 23:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789169463;
	bh=R8lNAqwWalBoaD+CK+ec3PxldoV2QLpznejgdKB/0Hk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TO53MoXFD366DLHUd52B/Q+byLuiZLc6oD27JFvdjAMnPhfKmxCAXDYqZqmIU8pL9
	 BBSd/9Cxoztx65abg4oM/+wqebARbUmdOOq95ZIJDbYk3ZKXJVBc9Ax1DsfXArN0c3
	 Q92+eg+pafMdkz7SK860EyojspJF3Sq2NyO+r2KAVyH0wHE/43z1NpkyukEF8L0NCl
	 SK19q/Tl5bb0/E+0d59ElkNMXI9YBZj+bqIIRZKWQsBaQfn2lAG9nrJnxks4HA0q+4
	 reIglsuAfQ3RdNYnnd5ezYKLd/pNDz3LajFnN+RfyRQQ79gf5dn0OzXrxdE40mNlzy
	 QZ/fdnjm7CIdQ==
Date: Sat, 12 Sep 2026 00:30:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Srirangan Madhavan <smadhavan@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Alex Williamson
 <alex.williamson@redhat.com>, vsethi@nvidia.com, alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, Vishal Aslot
 <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
Subject: Re: [PATCH v12 01/12] cxl: Move HDM decoder programming helpers
Message-ID: <20260912003057.3db9335c@jic23-hlaptop>
In-Reply-To: <20260910070808.1444264-2-smadhavan@nvidia.com>
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
 <20260910070808.1444264-2-smadhavan@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2026 07:07:57 +0000
Srirangan Madhavan <smadhavan@nvidia.com> wrote:

> Introduce struct cxl_decoder_settings as a snapshot of HDM decoder
> programming state. Collect endpoint skip and switch target-list state in
> hdm.c while holding the DPA lock, then pass the snapshot to generic commit
> helpers.
> 
> Move the low-level settings-based register programming into resource.c so
> later reset restore code can reuse it without depending on private decoder
> types.

This feels like two things in one patch. How much of this could be done by
code movement in a precursor patch then real changes in a follow up?

I'd like it to be a lot more obvious what has changed. 
Or failing that, introduce changes and then move the code in a follow
up patch.  Would still be easier to review than this combined patch.

Hopefully doing move and changes separately will also stop git diff
randomly interleaving old and new functions that are unrelated.

I've commented on some things but the diff is nasty enough I'll
wait for a split version to take a closer look at the bulk of this.

Jonathan


> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/Makefile   |   1 +
>  drivers/cxl/core/core.h     |   3 +
>  drivers/cxl/core/hdm.c      | 159 +++++++++++-------------------------
>  drivers/cxl/core/resource.c | 112 +++++++++++++++++++++++++
>  drivers/cxl/cxl.h           |  41 ----------
>  include/cxl/cxl.h           |  65 ++++++++++++++-
>  tools/testing/cxl/Kbuild    |   1 +
>  7 files changed, 227 insertions(+), 155 deletions(-)
>  create mode 100644 drivers/cxl/core/resource.c
> 
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index ce7213818d3c..57995777af0d 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -6,6 +6,7 @@ ccflags-y += -I$(srctree)/drivers/cxl
>  CFLAGS_trace.o = -DTRACE_INCLUDE_PATH=. -I$(src)
>  
>  cxl_core-y := port.o
> +cxl_core-y += resource.o
>  cxl_core-y += pmem.o
>  cxl_core-y += regs.o
>  cxl_core-y += memdev.o
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 35eaf636adc9..48fbc635975a 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -210,8 +210,11 @@ static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport) { }
>  int cxl_gpf_port_setup(struct cxl_dport *dport);
>  
>  struct cxl_hdm;
> +struct cxl_decoder_settings;
>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  			struct cxl_endpoint_dvsec_info *info);
> +int cxl_commit_start(void __iomem *hdm, struct cxl_decoder_settings *settings);
> +int cxl_commit_wait(void __iomem *hdm, struct cxl_decoder_settings *settings);
>  int cxl_port_get_possible_dports(struct cxl_port *port);
>  
>  #ifdef CONFIG_CXL_FEATURES
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b..70ffebd3e213 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -16,11 +16,6 @@
>   * for enumerating these registers and capabilities.
>   */
>  
> -struct cxl_rwsem cxl_rwsem = {
> -	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
> -	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
> -};
> -
>  static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld)
>  {
>  	int rc;
> @@ -679,122 +674,52 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
>  	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>  }
>  
> -static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
> +static u64 cxl_switch_get_target_list(struct cxl_switch_decoder *cxlsd)
>  {
> -	u16 eig;
> -	u8 eiw;
> -
> -	/*
> -	 * Input validation ensures these warns never fire, but otherwise
> -	 * suppress unititalized variable usage warnings.
> -	 */
> -	if (WARN_ONCE(ways_to_eiw(cxld->interleave_ways, &eiw),
> -		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
> -		return;
> -	if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
> -		      "invalid interleave_granularity: %d\n",
> -		      cxld->interleave_granularity))
> -		return;
> -
> -	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
> -	u32p_replace_bits(ctrl, eiw, CXL_HDM_DECODER0_CTRL_IW_MASK);
> -	*ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
> -}
> -
> -static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
> -{
> -	u32p_replace_bits(ctrl,
> -			  !!(cxld->target_type == CXL_DECODER_HOSTONLYMEM),
> -			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
> -}
> +	struct cxl_decoder *cxld = &cxlsd->cxld;
> +	u64 targets = 0;
> +	int ways = min(cxld->interleave_ways, cxlsd->nr_targets);
>  
> -static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
> -{
> -	struct cxl_dport **t = &cxlsd->target[0];
> -	int ways = cxlsd->cxld.interleave_ways;
> -
> -	*tgt = FIELD_PREP(GENMASK(7, 0), t[0]->port_id);
> -	if (ways > 1)
> -		*tgt |= FIELD_PREP(GENMASK(15, 8), t[1]->port_id);
> -	if (ways > 2)
> -		*tgt |= FIELD_PREP(GENMASK(23, 16), t[2]->port_id);
> -	if (ways > 3)
> -		*tgt |= FIELD_PREP(GENMASK(31, 24), t[3]->port_id);
> -	if (ways > 4)
> -		*tgt |= FIELD_PREP(GENMASK_ULL(39, 32), t[4]->port_id);
> -	if (ways > 5)
> -		*tgt |= FIELD_PREP(GENMASK_ULL(47, 40), t[5]->port_id);
> -	if (ways > 6)
> -		*tgt |= FIELD_PREP(GENMASK_ULL(55, 48), t[6]->port_id);
> -	if (ways > 7)
> -		*tgt |= FIELD_PREP(GENMASK_ULL(63, 56), t[7]->port_id);
> -}
> +	/* target_map[] holds the raw list before target[] is resolved. */
> +	for (int i = 0; i < ways && i < 8; i++) {
> +		u8 port_id;
>  
> -/*
> - * Per CXL 2.0 8.2.5.12.20 Committing Decoder Programming, hardware must set
> - * committed or error within 10ms, but just be generous with 20ms to account for
> - * clock skew and other marginal behavior
> - */
> -#define COMMIT_TIMEOUT_MS 20
> -static int cxld_await_commit(void __iomem *hdm, int id)
> -{
> -	u32 ctrl;
> -	int i;
> +		if (cxlsd->target[i])
> +			port_id = cxlsd->target[i]->port_id;
> +		else
> +			port_id = cxld->target_map[i];
>  
> -	for (i = 0; i < COMMIT_TIMEOUT_MS; i++) {
> -		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> -		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMIT_ERROR, ctrl)) {
> -			ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
> -			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> -			return -EIO;
> -		}
> -		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
> -			return 0;
> -		fsleep(1000);
> +		targets |= (u64)port_id << (i * 8);
>  	}
>  
> -	return -ETIMEDOUT;
> +	return targets;
>  }
>  
> -static void setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm)
> +static void cxl_decoder_snapshot(struct cxl_decoder *cxld,
> +				 struct cxl_decoder_settings *settings)
>  {
> -	int id = cxld->id;
> -	u64 base, size;
> -	u32 ctrl;
> +	lockdep_assert_held(&cxl_rwsem.dpa);

This messed up diff is an example of why moves and code changes should not
be in the same patch.  Hopefully if it's just moves we won't get this mess.

>  
> -	/* common decoder settings */
> -	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
> -	cxld_set_interleave(cxld, &ctrl);
> -	cxld_set_type(cxld, &ctrl);
> -	base = cxld->hpa_range.start;
> -	size = range_len(&cxld->hpa_range);
> +	*settings = (struct cxl_decoder_settings) {
> +		.id = cxld->id,
> +		.hpa_range = cxld->hpa_range,
> +		.interleave_ways = cxld->interleave_ways,
> +		.interleave_granularity = cxld->interleave_granularity,
> +		.target_type = cxld->target_type,
> +		.flags = cxld->flags,
> +	};
>  
> -	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
> -	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> -	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
> -	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> +	if (is_endpoint_decoder(&cxld->dev)) {
> +		struct cxl_endpoint_decoder *cxled =
> +			to_cxl_endpoint_decoder(&cxld->dev);
>  
> -	if (is_switch_decoder(&cxld->dev)) {
> +		settings->target_or_skip = cxled->skip;
> +	} else if (is_switch_decoder(&cxld->dev)) {
>  		struct cxl_switch_decoder *cxlsd =
>  			to_cxl_switch_decoder(&cxld->dev);
> -		void __iomem *tl_hi = hdm + CXL_HDM_DECODER0_TL_HIGH(id);
> -		void __iomem *tl_lo = hdm + CXL_HDM_DECODER0_TL_LOW(id);
> -		u64 targets;
>  
> -		cxlsd_set_targets(cxlsd, &targets);
> -		writel(upper_32_bits(targets), tl_hi);
> -		writel(lower_32_bits(targets), tl_lo);
> -	} else {
> -		struct cxl_endpoint_decoder *cxled =
> -			to_cxl_endpoint_decoder(&cxld->dev);
> -		void __iomem *sk_hi = hdm + CXL_HDM_DECODER0_SKIP_HIGH(id);
> -		void __iomem *sk_lo = hdm + CXL_HDM_DECODER0_SKIP_LOW(id);
> -
> -		writel(upper_32_bits(cxled->skip), sk_hi);
> -		writel(lower_32_bits(cxled->skip), sk_lo);
> +		settings->target_or_skip = cxl_switch_get_target_list(cxlsd);
>  	}
> -
> -	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
>  }
>  
>  static int cxl_decoder_commit(struct cxl_decoder *cxld)
> @@ -802,7 +727,8 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
>  	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
>  	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
> -	int id = cxld->id, rc;
> +	struct cxl_decoder_settings settings;
> +	int id = cxld->id, rc = 0;

I guess this rc = 0 is for compilers who can't tell always enter
scoped_guard().

Wasn't that problem fixed by:
https://lore.kernel.org/all/20241018113823.171256-1-przemyslaw.kitszel@intel.com/
?

>  
>  	if (cxld->flags & CXL_DECODER_F_ENABLE)
>  		return 0;
> @@ -815,10 +741,6 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  		return -EBUSY;
>  	}
>  
> -	/*
> -	 * For endpoint decoders hosted on CXL memory devices that
> -	 * support the sanitize operation, make sure sanitize is not in-flight.
> -	 */
>  	if (is_endpoint_decoder(&cxld->dev)) {
>  		struct cxl_endpoint_decoder *cxled =
>  			to_cxl_endpoint_decoder(&cxld->dev);
> @@ -826,6 +748,10 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  		struct cxl_memdev_state *mds =
>  			to_cxl_memdev_state(cxlmd->cxlds);
>  
> +		/*
> +		 * For endpoint decoders hosted on CXL memory devices that
> +		 * support the sanitize operation, make sure sanitize is not in-flight.

Odd line wrapping and I'm not sure why the move is here as you aren't
touching the relevant code.  If it makes sense for other reasons pull
it out as a precursor patch.

> +		 */
>  		if (mds && mds->security.sanitize_active) {
>  			dev_dbg(&cxlmd->dev,
>  				"attempted to commit %s during sanitize\n",
> @@ -834,10 +760,17 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  		}
>  	}
>  
> -	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
> -		setup_hw_decoder(cxld, hdm);
> +	scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
> +		cxl_decoder_snapshot(cxld, &settings);
> +		rc = cxl_commit_start(hdm, &settings);

Given this never returns anything not 0, make that void and
skip the error checks that follows.  We can bring it back
if that changes after this series.

> +	}
> +	if (rc) {
> +		dev_dbg(&port->dev, "%s: error %d committing decoder\n",
> +			dev_name(&cxld->dev), rc);
> +		return rc;
> +	}
>  
> -	rc = cxld_await_commit(hdm, cxld->id);
> +	rc = cxl_commit_wait(hdm, &settings);
>  	if (rc) {
>  		dev_dbg(&port->dev, "%s: error %d committing decoder\n",
>  			dev_name(&cxld->dev), rc);
> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> new file mode 100644
> index 000000000000..64e63114cfbf
> --- /dev/null
> +++ b/drivers/cxl/core/resource.c
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
> +#include <linux/delay.h>
> +#include <linux/bug.h>
> +#include <linux/errno.h>
> +#include <linux/export.h>
> +#include <linux/kernel.h>
> +
> +#include "cxl.h"
> +#include "core.h"
> +
> +struct cxl_rwsem cxl_rwsem = {
> +	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
> +	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
> +};
> +
> +static void cxld_set_interleave(struct cxl_decoder_settings *settings, u32 *ctrl)
> +{
> +	u16 eig;
> +	u8 eiw;
> +
> +	/*
> +	 * Input validation ensures these warns never fire, but otherwise
> +	 * suppress uninitialized variable usage warnings.
> +	 */
> +	if (WARN_ONCE(ways_to_eiw(settings->interleave_ways, &eiw),
> +		      "invalid interleave_ways: %d\n",
> +		      settings->interleave_ways))

Keep old wrapping. It's fine to go over 80 chars and in this case the reason
is to make it easier to see no actual change in the code movement.

> +		return;
> +	if (WARN_ONCE(granularity_to_eig(settings->interleave_granularity, &eig),
> +		      "invalid interleave_granularity: %d\n",
> +		      settings->interleave_granularity))
> +		return;
> +
> +	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
> +	u32p_replace_bits(ctrl, eiw, CXL_HDM_DECODER0_CTRL_IW_MASK);
> +	*ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
> +}
> +
> +static void cxld_set_type(struct cxl_decoder_settings *settings, u32 *ctrl)
> +{
> +	u32p_replace_bits(ctrl,
> +			  !!(settings->target_type == CXL_DECODER_HOSTONLYMEM),
> +			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
> +}
> +
> +/*
> + * Per CXL 2.0 8.2.5.12.20 Committing Decoder Programming, hardware must set
> + * committed or error within 10ms, but just be generous with 20ms to account for
> + * clock skew and other marginal behavior.
> + */
> +#define COMMIT_TIMEOUT_MS 20
> +static int cxld_await_commit(void __iomem *hdm, int id)
> +{
> +	u32 ctrl;
> +	int i;
> +
> +	for (i = 0; i < COMMIT_TIMEOUT_MS; i++) {

	for (unsigned int i; i <...

Mind you if this were just code movement leaving it alone better
and maybe chasing with a tidy up patch at somepoint.


> +		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMIT_ERROR, ctrl)) {
> +			ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
> +			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +			return -EIO;
> +		}
> +		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
> +			return 0;
> +		fsleep(1000);
> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static int setup_hw_decoder(void __iomem *hdm,
> +			    struct cxl_decoder_settings *settings)
> +{
> +	int id = settings->id;
> +	u64 target_or_skip;
> +	u64 base, size;
> +	u32 ctrl;
> +
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	cxld_set_interleave(settings, &ctrl);
> +	cxld_set_type(settings, &ctrl);
> +	base = settings->hpa_range.start;
> +	size = range_len(&settings->hpa_range);
> +	target_or_skip = settings->target_or_skip;
> +
> +	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
> +	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> +	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
> +	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> +	/* Target-list and endpoint-skip registers alias the same slot. */
> +	writel(upper_32_bits(target_or_skip),
> +	       hdm + CXL_HDM_DECODER0_TL_HIGH(id));
> +	writel(lower_32_bits(target_or_skip),
> +	       hdm + CXL_HDM_DECODER0_TL_LOW(id));

I'd not worry about going one or two chars over 80. Just put these on one line
each.

> +
> +	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +
> +	return 0;

Does this function ever return non zero? I couldn't spot it in
later patches in this series. If not, void and that might propagate
to the callers - I haven't checked.

> +}

> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 802b143de83d..c09492af8fbd 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -5,8 +5,10 @@
>  #ifndef __CXL_CXL_H__
>  #define __CXL_CXL_H__
>  
> +#include <linux/device.h>
>  #include <linux/node.h>
>  #include <linux/ioport.h>
> +#include <linux/range.h>
>  #include <cxl/mailbox.h>
>  
>  /**
> @@ -23,7 +25,68 @@ enum cxl_devtype {
>  	CXL_DEVTYPE_CLASSMEM,
>  };
>  
> -struct device;
> +struct cxl_region;
> +
> +enum cxl_decoder_type {
> +	CXL_DECODER_DEVMEM = 2,
> +	CXL_DECODER_HOSTONLYMEM = 3,
> +};
> +
> +/**
> + * struct cxl_decoder_settings - CXL HDM decoder programming snapshot
> + * @id: decoder id
> + * @hpa_range: Host physical address range mapped by this decoder
> + * @target_or_skip: switch target list or endpoint skip register value
> + * @interleave_ways: number of cxl_dports in this decode
> + * @interleave_granularity: data stride per dport
> + * @target_type: accelerator vs expander (type2 vs type3) selector
> + * @flags: memory type capabilities and locking
> + */
> +struct cxl_decoder_settings {
> +	int id;
> +	struct range hpa_range;
> +	u64 target_or_skip;
> +	int interleave_ways;
> +	int interleave_granularity;
> +	enum cxl_decoder_type target_type;
> +	unsigned long flags;
> +};
> +
> +/*
> + * Current specification goes up to 8, double that seems a reasonable
> + * software max for the foreseeable future
> + */

That comment has been wrong for a while (for EPs at least).
Would you mind adding a precursor patch to just delete it, ideally with a spec
reference to say when it changed.  Anyhow definitely don't want to move it!
*cough* It's almost like whoever wrote that comment knew that the spec was
changing to increase this 16 :)

> +#define CXL_DECODER_MAX_INTERLEAVE 16
> +
> +/**
> + * struct cxl_decoder - Common CXL HDM Decoder Attributes
> + * @dev: this decoder's device
> + * @id: kernel device name id
> + * @hpa_range: Host physical address range mapped by this decoder
> + * @interleave_ways: number of cxl_dports in this decode
> + * @interleave_granularity: data stride per dport
> + * @target_type: accelerator vs expander (type2 vs type3) selector
> + * @flags: memory type capabilities and locking
> + * @region: currently assigned region for this decoder
> + * @target_map: cached copy of hardware port-id list, available at init
> + *              before all @dport objects have been instantiated. While
> + *              dport id is 8bit, CFMWS interleave targets are 32bits.
> + * @commit: device/decoder-type specific callback to commit settings to hw
> + * @reset: device/decoder-type specific callback to reset hw settings
> + */
> +struct cxl_decoder {
> +	struct device dev;
> +	int id;
> +	struct range hpa_range;
> +	int interleave_ways;
> +	int interleave_granularity;
> +	enum cxl_decoder_type target_type;
> +	unsigned long flags;
> +	struct cxl_region *region;

This reorders fields from where it came from. If that makes sense, separate
patch with an explanation of why.  For a code move patch
we want absolutely no unnecessary changes.

> +	u32 target_map[CXL_DECODER_MAX_INTERLEAVE];
> +	int (*commit)(struct cxl_decoder *cxld);
> +	void (*reset)(struct cxl_decoder *cxld);
> +};
>  


