Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31E837A84F;
	Tue, 11 Aug 2026 05:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786426390; cv=none; b=rXwAo85KFaPIZQOR/I4uyfIJsxETDRF6RGvMYx6dq/3pZvUclRbFqw5LGdeA3qDUjKOHxKIKjzzvY/ftvDwIl0ame+l2nFLaZ146ZM8mZR8Zmeik9QcJFJq9fzjRdanvPd1/XMfibBCD0QwSgECuX1KGHeyuVHBZSG+rVlZIY8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786426390; c=relaxed/simple;
	bh=4VVBiuz3m9mlBNyeXMX0lsCANevSWyu+69OXAQpYAFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ri28aQxbu/LjwHDHZGeje1Nl3fW9yy5qM8lU0I0vXpJkqvqStF6r+vyJdvtYWwLAaJJx7woSSXqo/ZA5XS8wa3PMvlGajNz5lwJG62xr8tz2/tfyWvWqkJZNCgJXJxIy55nSWyLrCA6BLDfPZragDO4S/WHkZWe/LIgvIjjjqHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gl+L5FQe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gl+L5FQe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D4D1F000E9;
	Tue, 11 Aug 2026 05:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786426389;
	bh=91IbCEuqOE7g+QcwQ0ibJY5PBo9NpBEpNMyFBjpQ0pQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Gl+L5FQeWTliV6kU3L1XDS5OmvuVLT69/rzA86Y4UWO2o9xNhBkKdvJhYQysdJF8J
	 3BDv+XAxm3nADUrfeCASGP0GREt9HKsl4a+BDcpznFR5zN8RP2/ziJPsBAXIKFWd3P
	 vnpRMkI8wWW/lh2s/MmvGn/1plVyNd1hKFPyaume2iz1nua0U/FPLt23zWKndBEjur
	 RAhvGkITav/0xEwzf7kQfDTAzPcHsfNiXIw3LsJbcCIoblYmIux364EYar29L1zSPn
	 u2BseEhudsHpEVyMhWwvbpXuuZXKmphJqlEp1E1lb87+L6t4NCJx9xKH+u+76TU6LH
	 KCHCtzQwAqjvA==
Date: Tue, 11 Aug 2026 07:33:00 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Max Lee <max.lee@canonical.com>, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, acelan.kao@canonical.com, 
	helgaas@kernel.org, kaihengf@nvidia.com, victorshihgli@gmail.com, pandoh@google.com
Subject: Re: [PATCH v3] PCI: Disable ASPM L0s for Realtek RTS525A
Message-ID: <5niqa6cg2ctli6zrufxzzd2cf7mj2pqz2ufobwgu6qiugmmtog@lum7yo7xdy2a>
References: <20260610024723.188514-1-max.lee@canonical.com>
 <20260706025358.516607-1-max.lee@canonical.com>
 <jnxtx4pl36dzuddqugpfack5hfmwo2wazg5t7g2sill37urtng@3bvsmzehfygl>
 <anWSVNqltYAjvq2p@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anWSVNqltYAjvq2p@wunner.de>

Hi Lukas,

On Fri, Aug 07, 2026 at 10:07:48AM +0200, Lukas Wunner wrote:
> Hi Mani,
> 
> On Mon, Jul 06, 2026 at 12:20:07PM +0200, Manivannan Sadhasivam wrote:
> > On Mon, Jul 06, 2026 at 10:53:58AM +0800, Max Lee wrote:
> > > Prevent the broken L0s configuration by removing L0s from the RTS525A
> > > advertised ASPM capability.  This avoids enabling the non-working ASPM
> > > state instead of masking the resulting AER Replay Timer Timeout reports.
> > > 
> > 
> > If you can add the AER log snippet here, it will help others to find
> > this quirk in the future.
> [...]
> > s/Replay Timer Timeouts/Replay Timer Timeout Storm
> > 
> > to stress the severity.
> 
> Max submitted a v4 which I believe addresses your comments,
> but it hasn't been applied yet.  Would you be able to apply it?
> 
> https://lore.kernel.org/r/20260707021527.639611-1-max.lee@canonical.com/
> 

Sorry, I can only apply patches pertaining to Host Controller (pci/controller)
and Endpoint (pci/endpoint). Rest has to go through Bjorn.

> I'm asking because there's now another ASPM problem report pending
> for the RTS525A:
> 
> https://lore.kernel.org/r/20260806214808.1202819-1-derekjohn.clark@gmail.com/
> 

@Bjorn: Could you please take a look at these Quirk pat hes?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
