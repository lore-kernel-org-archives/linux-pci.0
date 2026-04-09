Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C925737883C
	for <linux-pci@vger.kernel.org>; Thu,  9 Apr 2026 08:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775721839; cv=none; b=MGSoCFOQ/piTE6SX0/vp9fbfIaBrLdRW3qXf1gU9sBTRSAPwtTsdMA7zn4BlXfARDbFp7s9C7yMLI3gNzozT/z/N0IbX4xM3NJC8ubXcTnJ9ihmxaNY0/6H+NvBZltE/y/InS3xuGQsd0vsHQINiqwOgU1xRYSLxcGhgAyqutdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775721839; c=relaxed/simple;
	bh=vLMuceyb1911q6XVoxtnDGiburqo0GjA6HdzZrSxkKo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VvUOgz2Aaii1gjo/lUdv/aDIgo4gvFXci5MOf9521qxDAggxah8Y4DusjLttnskUyT6QrmCq26/15R+2vhuI+10Wj9anycPnaiPwTfbC5wXzWeYEGureFJa1EifSpoaViqwMjdTyL80PNFP5ssuocHarmhmvmE4lbmin0EwteI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kwWHT6ES; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kwWHT6ES"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775721838; x=1807257838;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vLMuceyb1911q6XVoxtnDGiburqo0GjA6HdzZrSxkKo=;
  b=kwWHT6ESqH9LDFbFadrm3J9f/Y4sj7DQyx4E2NHyV8mHqfdMJbh7+n5I
   RmhORiUaVyRGsaOVIBAk3Wa3ger7RKt/uKxrlCybnxMNG1yLPmVqBE3Yl
   p7S1uiHlyzBpfqJsPNBLhu8NwELwDIydeUiFJRkP3HRc0Sg4bWE3ny5nE
   L6wqbaltg8d4zI0SZd8SYKh48AQZk2h9UMBDlpRFwJ3WpJVDaI6sYfRUh
   C5OBPP1IZ/TszzgtP8dPCr20+3+EDNl3u2BpKxS+H1iwyRfm8DtlS67kd
   NIy/S4QSThwJU9fbZrhh6Jdwy7dVMghX34mJ72VwChDqwyxqgEEpst9dx
   g==;
X-CSE-ConnectionGUID: GPaIjS4sSuSyepGYsA2+SQ==
X-CSE-MsgGUID: zo0J/rMrQSqwHIONPl22KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76608477"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="76608477"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 01:03:57 -0700
X-CSE-ConnectionGUID: RsGcdkChSXqMDpAXj4otTQ==
X-CSE-MsgGUID: b8cICYO5Rq6MrO4zBwuPtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="228632823"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.197])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 01:03:54 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 9 Apr 2026 11:03:50 +0300 (EEST)
To: Geramy Loveless <gloveless@jqluv.com>
cc: linux-pci@vger.kernel.org, Cristian Cocos <cristi@ieee.org>
Subject: Re: [PATCH] PCI: release empty sibling resources during bridge window
 resize
In-Reply-To: <CAGpo2meKY6SXsESU-D0PGgbESLqdF8UBF-tmThxOvk2XUDpEzw@mail.gmail.com>
Message-ID: <4203a8ea-25a3-72e1-c071-db371be045e1@linux.intel.com>
References: <CAGpo2meKY6SXsESU-D0PGgbESLqdF8UBF-tmThxOvk2XUDpEzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 8 Apr 2026, Geramy Loveless wrote:

Thanks for the patch. The patch need some work but the general direction 
looks acceptable.

FYI, your patch is misformatted, tabs got eaten, probably something in 
tha way you send the email does that.

Please Cc also Cristian Cocos <cristi@ieee.org> on further submissions.

> When pci_resize_resource() walks up the bridge hierarchy via
> pbus_reassign_bridge_resources(), bridge windows with any child
> resources are refused release. This prevents BAR resize on devices
> behind multi-port PCIe switches (such as Thunderbolt docks) where
> empty sibling downstream ports hold small reservations that block the
> parent bridge window from being freed and re-sized.
> 
> Add pci_bus_release_bridge_resources_safe() which verifies that a
> resource subtree contains no active children before releasing it,
> and use it in pbus_reassign_bridge_resources() to clear empty sibling
> reservations so the bridge window can grow.
> 
> Signed-off-by: Geramy Loveless <gloveless@jqluv.com>

You may want to add Suggested-by tag.

> ---
> drivers/pci/setup-bus.c | 30 +++++++++++++++++++++++++++---
> 1 file changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 4cf120ebe..9a3a23819 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -2297,6 +2297,30 @@
> EXPORT_SYMBOL_GPL(pci_assign_unassigned_bridge_resources);
> * release it when possible. If the bridge window contains assigned
> * resources, it cannot be released.
> */
> +
> +/*
> + * Release child resources from a bridge window so it can be freed and
> + * re-sized, but only if the entire subtree is empty (no active device
> + * resources underneath). Walks the resource tree recursively to handle
> + * arbitrarily deep bridge hierarchies. Returns true if the resources
> + * were released or the window was already empty.
> + */
> +static bool pci_bus_release_bridge_resources_safe(struct pci_bus *bus,
> + struct resource *res)
> +{
> + struct resource *child;
> +
> + for (child = res->child; child; child = child->sibling) {
> + if (child->child &&
> + !pci_bus_release_bridge_resources_safe(bus, child))
> + return false;

This should walk bus devices and device resources using PCI side
iterators (not using the low-level resource list). This does not look 
safe iteration anyway because the code is also removing entries from the 
resource tree (it only works because resource code leaves stale sibling 
pointers which should be corrected one day).

PCI side should be enough to capture all resources, and that way you 
still have access to all PCI side structs.

Perhaps sanity checking ! ->child at the end wouldn't hurt but it the
release should be doable.

You should also pass the saved list and store any released resources so 
you can properly rollback in case of a failure (I think the rollback 
code will already just-work as long as you add the entries there).

> + }
> +
> + if (res->child)
> + pci_bus_release_bridge_resources(bus, res, whole_subtree);

I think this could pass non-bridge window resources which looks wrong but 
you need to rewrite the algorithm in this function anyway.

> + return true;
> +}
> +
> static int pbus_reassign_bridge_resources(struct pci_bus *bus, struct
> resource *res,
> struct list_head *saved)
> {
> @@ -2316,8 +2340,8 @@ static int pbus_reassign_bridge_resources(struct
> pci_bus *bus, struct resource *
> i = pci_resource_num(bridge, res);
> - /* Ignore BARs which are still in use */
> - if (!res->child) {
> + if (!res->child ||
> + pci_bus_release_bridge_resources_safe(bridge->subordinate, res)) {

Just call this release always before checking !res->child.

You need to check bridge->subordinate before calling it.

> ret = pci_dev_res_add_to_list(saved, bridge, res, 0, 0);
> if (ret)
> return ret;
> @@ -2327,7 +2351,7 @@ static int pbus_reassign_bridge_resources(struct
> pci_bus *bus, struct resource *
> const char *res_name = pci_resource_name(bridge, i);
> pci_warn(bridge,
> - "%s %pR: was not released (still contains assigned resources)\n",
> + "%s %pR: not released, active children present\n",
> res_name, res);
> }
> 

-- 
 i.

