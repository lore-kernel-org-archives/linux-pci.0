Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0472362137;
	Thu,  2 Apr 2026 16:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775149184; cv=none; b=iY1FHYfVl3EyK7WtvoXrTpmce/zOjd/PnDbHsPLL71honWXWwiPVNxkZa6x2nKmyLfR8NnNnPgCGQodHJ5cbJDRcNJkSgKn24ZQhow8q82Y2t4OlZvxtwTCvgA+jRiqdimRi9bsyBwEHfwRTxHkDxeUtj7EFevV7y2CoURp4G8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775149184; c=relaxed/simple;
	bh=bs3HJXRezDszAXCL9RozlYwMQtCrsSyiFLc8vVRxzGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqA5JdPTGud2BEk7fhUaN4jxKCrGA2gv9OE73pKQ13QR4S+h5MqPE2qkS1vWCOy+zaH0Aav7+IdHnjT5j/OzpnfSfNxuJ17jnOL4UbFFVRRY4H9jTjCpYmvnf2OZnLjdoYfQIpXTM9fAdPaIgSPU9vJF4HkyrN5L6TSVp1H4FzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kI7VfszE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kI7VfszE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6272C116C6;
	Thu,  2 Apr 2026 16:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775149183;
	bh=bs3HJXRezDszAXCL9RozlYwMQtCrsSyiFLc8vVRxzGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kI7VfszEYot20dHot4OG2o2I8+rbTT84X1oZzd3geu/g0xAkY8bgnqsCeKc0m4t06
	 K1FJfknzugXFIorn1DY4ZGFdcqWgxDmbAQ9u53wIpoPYFIljpBgrM0Wt13VAvJO4mt
	 cRseTlzRt2Mjyw5/cvssqPrxNjzOyJ6QbFxXsMcpfNQiMgO3ITiSZTFu6xdEOGrCSy
	 5oW7PbNGlw/Hd5olXlJ5E2mOTRal7+/AakXWC4JHdhR89w+4C28sug4urrt3Z7yiiq
	 ATHCnNscoYjMXpDzKbssi5/6JPq+hQ9XIyz3tXGRWOonXWOED0m+XPplbrP3RHx8ZA
	 Tw+QPf6yqcZFQ==
Date: Thu, 2 Apr 2026 22:29:34 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [GIT PULL] PCI: tegra: Changes for v7.1-rc1
Message-ID: <lduiidifejglrep2laxzk2hep5rxpm3ysz5cwhdsglf6ciyjp4@z2dmnlvi7nhi>
References: <20260329155040.1448158-1-thierry.reding@kernel.org>
 <ac5ZGItkKNEI_W1-@orome>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac5ZGItkKNEI_W1-@orome>

On Thu, Apr 02, 2026 at 01:56:48PM +0200, Thierry Reding wrote:
> On Sun, Mar 29, 2026 at 05:50:39PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <thierry.reding@gmail.com>
> > 
> > Hi Lorenzo, Bjorn,
> > 
> > The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:
> > 
> >   Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-7.1-pci
> > 
> > for you to fetch changes up to a0c0906bb09ee2f64690b3b8ffb458b4dbbcb26e:
> > 
> >   PCI: tegra: Add Tegra264 support (2026-03-28 15:00:05 +0100)
> > 
> > This is v3 of the Tegra264 PCI patches that can be found here:
> > 
> >   https://lore.kernel.org/linux-pci/20260326135855.2795149-1-thierry.reding@kernel.org/
> > 
> > This looks ready now, but if there's any more feedback, I will happily
> > respin these driver patches.
> > 
> > Note that the shortlog and the diffstat below include the dependencies
> > from the Tegra tree, and that subset will go in through the ARM SoC tree
> > as well. Effectively what's new in this pull request is just the two PCI
> > patches, the rest is only included here to resolve the build time
> > dependencies.
> 
> I'm retracting this PR. DT maintainers aren't happy about how I handled
> this, so it'll have to wait for another release cycle.
> 

JFYI, We don't pull from PCI patches from other trees. We only merge them by
ourselves.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
