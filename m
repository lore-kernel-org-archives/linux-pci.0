Received: from o1.ptr9745.em.honeycomb.io (o1.ptr9745.em.honeycomb.io [149.72.141.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589A056510E
	for <linux-pci@vger.kernel.org>; Tue,  8 Sep 2026 23:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.72.141.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788909940; cv=none; b=muaEM5A/qplNLUSCVtXUrdzExSNYy09NGIq/B09P01g2d+UYB5OR9CPFdA1m/kGB9Kr73XIYL7EAvPt5ACPZrwvp0Ccz9MAE7RtrzImTljx0wvO/Mg6HiaxOmejQbXZSf9F8jVKMzOeeMPp2oUuoZ2NLcDancug8U3WJ0PkQnY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788909940; c=relaxed/simple;
	bh=IpRRbmraEQdRvYU+gOwK0kySHffEqkNVDWp175KjZQU=;
	h=From:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 To:Cc:Content-Type; b=lfkZM/7gu3vv20RbsaCLfqQqJooPze32p3QWv3WzScpoePdUSTQ2EY0vCGg+5HRjyZ4Uphz2d3bDyRdNgAVcamK0s6reJQJV+NMazguqgUg0Ed5TcVFiPizkjE87ZuMTJ2+oYUFjE+TEKE54XMpopx3VqqQpAdQW22RdoZMPQew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=honeycomb.io; spf=pass smtp.mailfrom=em.honeycomb.io; dkim=pass (2048-bit key) header.d=honeycomb.io header.i=@honeycomb.io header.b=aL8NPyt9; arc=none smtp.client-ip=149.72.141.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=honeycomb.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em.honeycomb.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=honeycomb.io header.i=@honeycomb.io header.b="aL8NPyt9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=honeycomb.io;
	h=from:subject:date:in-reply-to:references:mime-version:to:cc:
	content-transfer-encoding:content-type:cc:content-type:date:from:subject:to;
	s=s1; t=1788909938;
	bh=+cqP2z/XRk+D/XjM5uu7L4wIVdn+LO6xQ4ZwBaRcgNQ=;
	b=aL8NPyt9nOYEzQuV2WnCkoOszajRz6gsRuNTpo850LYcPnYYitNnzFITVIX5vNGQQtZb
	HnyvYRmPteSZ+GhUeANWllHZzi6CmYvlUFkNEz1jR6YWGjRD4kngsMCKH6BVdDhbg+utpF
	hPM5ZlwyiEtx+Tf8H1uZPaz2nSMAkoLY26OctoJCQd4V78NXx0TDQHK7AY17sHWLRWQc3U
	olPQHRx8grAhGcxNDpZRzXvUk2alul0m4VUEkgzbLXjT0SkzvhFT4CQKXJMG+m7JsUW8yR
	zW1irbH9BAt271Mcg2dk2Lvx8DF3KO07jwaiEGsr6S2xRVNZgWjzZ00wQhHGBb5A==
Received: by recvd-5c6d7fbdd5-l2fc6 with SMTP id recvd-5c6d7fbdd5-l2fc6-1-6AA09972-3C
	2026-09-08 23:25:38.34628099 +0000 UTC m=+511381.869181742
Received: from daisy.dens.ffj.family (unknown)
	by geopod-ismtpd-16 (SG)
	with ESMTP
	id -M_K5BBjQs23qTbHcrNBTQ
	Tue, 08 Sep 2026 23:25:38.281 +0000 (UTC)
From: Liz Fong-Jones <lizf@honeycomb.io>
Subject: Re: [PATCH v5] PCI: Fix BAR resize for devices on a root bus
Date: Tue, 08 Sep 2026 23:25:38 +0000 (UTC)
Message-ID: <20260908232537.64461-1-lizf@honeycomb.io>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908231349.682101F00A3A@smtp.kernel.org>
References: <20260908231349.682101F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SG-EID: 
 =?us-ascii?Q?u001=2ECuH7N2XAoeMR1zrzr=2F6NZrhli2vbKPOHff5fJuZuba6ZIE8QPyIf9mn4Y?=
 =?us-ascii?Q?ezqeFFjUkh=2FeROy4LtnO7KN9jZmeSexUlkeuf81?=
 =?us-ascii?Q?gWnfLpBOWbKd5gENM0vuDG1ojsEgaQqWFUTyYLE?=
 =?us-ascii?Q?dJf8oZJuNjmdWXsRO0cfRh+gdK7Ffn5rTg6H9mL?=
 =?us-ascii?Q?OD4lrFKjZiWNavnvTYpz8myV94n99trA0ggw8=2FJ?=
 =?us-ascii?Q?cRRSJQ2Og+z0S6U72EO8pb5TIBJfiE7hw5WRAKx?= =?us-ascii?Q?dnt+?=
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-pci@vger.kernel.org, lizf@honeycomb.io
X-Entity-ID: u001.GRlkmHQ+Ka/CKxmoC/CxTw==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii

On Sashiko (Gemini 3.1 pro preview) wrote:
> Finding 1: Optional Resource Assignment Failure
> Severity: High
>
> Location: drivers/pci/setup-bus.c, lines 2429-2433
>
> Issue: The stricter validation incorrectly treats optional resources
> (ROM BARs) as required. If pci_bus_assign_resources() succeeds for
> the target BAR but leaves an optional resource unassigned, the
> function aborts with -ENOSPC, breaking valid BAR resizes.

This is a known, deliberate tradeoff, not an oversight -- it's
disclosed directly in the v5 commit message:

  "Unlike the bridged path, this treats failure to place any released
  resource -- including optional ones, e.g. an unclaimed expansion
  ROM -- as fatal, rather than checking only required resources.
  That's the more conservative choice: on a root bus everything
  released here tends to share one window, and failing loudly seemed
  better than leaving something silently unassigned."

Concretely, for the bug this patch fixes it doesn't apply at all: the
device's ROM shares a different resource window than the released
BARs (confirmed against the actual hardware log -- only BAR0 and BAR2
are ever released, no ROM), so it's never in the "saved" list this
check walks. The scenario in the finding is theoretical for other
root-bus devices whose optional resources do share the same window
as the target BAR, not something this bug's hardware or reported
failure exercises.

Marking this a false positive rather than a code defect. Finding 2
("Preexisting") is correctly scoped and not disputed.

