Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EC33C4566;
	Wed, 18 Mar 2026 11:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773833268; cv=none; b=QLdUzGgMoVXADjXYP4WL24enoYk72Z9QXF4wmgmCmgZCereWDvpMHtoaup4LBeIiO7jQikbXbdt2yUwTcspCWqGOyD7WWv4uLpFHEcFbmL05MolocdOSQFTNLaw7BWVs10whDOsnsT1QwO72jcT5EBR7IeI5MCseLHoDR9fvagk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773833268; c=relaxed/simple;
	bh=2urEpsel31KBLi0R41Vk+HjOZ+oJYk9u5tgFyfXXJl4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eTnEyjQ/l/UM63U9SeDBOdXxYOyYpTg3P2r/AUjSSVcipvEpVdvbcvWM7wJru+/LyRC9UESk9G3lS01T7BgSI5v30i/dRebhBf1ZyfXmvhDHYdvy25Es7svTnamhP/Dmaa0Iei0deIi2QdIyuyjcKCUVMNOub8OmnoknQOAtMuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RindKiYs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RindKiYs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C0DC19421;
	Wed, 18 Mar 2026 11:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773833267;
	bh=2urEpsel31KBLi0R41Vk+HjOZ+oJYk9u5tgFyfXXJl4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RindKiYsqoe+toNVHlRQk0QjvJHX6si/gvB7R3EYa1N/5IKCGDfR9826th/qOlA95
	 u/1cDsvQkZS4lAUrTi784nrH8VUSjuq6t81JglwimRZBkV6KjKMSR6OVWniAcH3+NQ
	 nDOmFGxgLSLd8P6oopngRSH3RWTJqsJb8QXFE9+Iq+prBkckmPhELedTZaMQX+cS7f
	 SgwVMSF5wKrx63rOaSOvmLctAdgT1q3x1rtpctZShudsfZJKjRRYBMPfWq1FwNabQL
	 u7w3rEqFURq965cjNx4UdVGe/vy/X0wZ6kXXe1Ldau6uu/S9ka5vzRKrSTlr9UTN2I
	 m3hhxSzaqU5zw==
From: Vinod Koul <vkoul@kernel.org>
To: bhelgaas@google.com, mani@kernel.org, 
 Devendra K Verma <devendra.verma@amd.com>
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, michal.simek@amd.com, Devendra.Verma@amd.com
In-Reply-To: <20260318070403.1634706-1-devendra.verma@amd.com>
References: <20260318070403.1634706-1-devendra.verma@amd.com>
Subject: Re: [PATCH v15 0/2] Add AMD MDB Endpoint and non-LL mode Support
Message-Id: <177383326516.408483.6251922217813807618.b4-ty@kernel.org>
Date: Wed, 18 Mar 2026 16:57:45 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 18 Mar 2026 12:34:01 +0530, Devendra K Verma wrote:
> This series of patch support the following:
> 
>  - AMD MDB Endpoint Support, as part of this patch following are
>    added:
>    o AMD supported device ID and vendor ID (Xilinx)
>    o AMD MDB specific driver data
>    o AMD specific VSEC capabilities to retrieve the base of
>      phys address of MDB side DDR
>    o Logic to assign the offsets to LL and data blocks if
>      more number of channels are enabled than configured
>      in the given pci_data struct.
> 
> [...]

Applied, thanks!

[1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
      commit: 14eb9a1d338fdc301a2297af86818ecf716b1539
[2/2] dmaengine: dw-edma: Add non-LL mode
      commit: b7560798466a07d9c3fb011698e92c335ab28baf

Best regards,
-- 
~Vinod


