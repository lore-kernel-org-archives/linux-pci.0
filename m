Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C613BE65A
	for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773158629; cv=none; b=WerfK20A/NHy7MLDsGA2ommMvcx1jQVz1WHnTlFcRn6+o1LwmXNDzBZuLH3uh9DidoAM/9ko6ajKJLJSiQF2nM1z3xnmqMqqRc0JrcL++e2s45kHP8OkCSuQOT3feYXpYjjic8/b2tPu6PSjxeaH10JT33ffndxTuiE1UuZChwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773158629; c=relaxed/simple;
	bh=1z1n+QQN96Ij/JW1hCeE1L5nQa5fZ5FjPHafDHZTweU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Or1zEJBaZNYPND6o8RYRnGU/8ly4TmntSbUtzxWx4+Hl1l0lKAd7l1GWxHxISLsjuzUCrrsLRKjEGD1eq5KId7soInukWwt6Bh4NGQJzNUmZWDENHuI7mfyZoeO5fPZNHHtD3G5YKgFTGh2uLWvDgz5OsynBMBHpIYcefwu4Hus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDheg/xw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDheg/xw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C858C19423;
	Tue, 10 Mar 2026 16:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773158629;
	bh=1z1n+QQN96Ij/JW1hCeE1L5nQa5fZ5FjPHafDHZTweU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jDheg/xwyaHTtEh150p51HnQVtCQ6Ul2tKl3TV8A5uCjPfkT08EITbzn1x6uOteNW
	 Sr1LcFMT9glvHVXKqiIG8TUywPHUHq7bHF7cshsvRBYu2VnlwRAwO4fap2VOJhx8Js
	 8SaFzckYdNNBX862D1w9tNbp7vwRcdfxo9Gu4o5uEnvoooQdnz0WPs5bTs29cLG1qX
	 muA0LSVvBGDxAgVsRX8cApwBPZAp5pOk049om3sDEK2LsZl1+zolJYMy1kAUCGnJbM
	 yx5GJeuHI6Yh4FfD+8tm6qKBHFVe28DxV+cYuekJtiMhxPrvqaVYkrigIMPnAF488V
	 MZIPEYtuCCCYA==
Date: Tue, 10 Mar 2026 11:03:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	alok.a.tiwarilinux@gmail.com
Subject: Re: [PATCH] PCI: Fix incorrect retval type in remove_id_store()
Message-ID: <20260310160347.GA680013@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ad69182-8e04-4a44-99d9-c55e2fabc3b2@oracle.com>

On Tue, Mar 10, 2026 at 08:36:25AM +0530, ALOK TIWARI wrote:
> On 3/10/2026 3:50 AM, Bjorn Helgaas wrote:
> > On Tue, Feb 24, 2026 at 10:14:29AM -0800, Alok Tiwari wrote:
> > > remove_id_store() initializes retval with -ENODEV, but retval was
> > > declared as size_t. Since size_t is unsigned, the negative value is
> > > converted to a large positive number, breaking error handling.
> >
> > Does this actually cause a problem?

Can you answer this question?  I think the patch itself is OK, but I
don't want to claim that it fixes broken error handling unless there's
actually some way to observe that broken behavior.
