Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595DA234973;
	Thu, 22 Jan 2026 13:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769088365; cv=none; b=hFgaS1b0OvFmDKzyG5+w9kGNtPWAHAiPOufMp9UlHYc1WdAeBbf/wOnIbSHrtxN8yXkSxuD2zxwcTUvtvmitIFq7dF1+JyPBjwC6kl4SXZg5WhB/fEIiSeWOma/0TLBu9iughUhcgrVog3i7mamSd5/8CvU52iBqyeRVGBHJXd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769088365; c=relaxed/simple;
	bh=CmAY+q/rceSfk7HDTugzOyxloBuDfXy+nuOxUprtVPk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XDd6EVvtWa6B45KOE8sHgj2+QxWk/X8IhIjCEqY6Vcb6k8jXl5C3TKWEsMAJRXe3IqSYGiMEPp5dzlq06BaLJ3CDzLvycnLObbreVLYqOrmXTDyBl6mlUDiSBgB9uVUWZ3d56FOV+6ZReEGbPPwic2W/4uNsTAoQwSM7zl/vL8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILQTIXph; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILQTIXph"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84E4C116C6;
	Thu, 22 Jan 2026 13:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769088364;
	bh=CmAY+q/rceSfk7HDTugzOyxloBuDfXy+nuOxUprtVPk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ILQTIXph4iKF0EIDIcsSKyEWUfKqobzyKu0kPebckmgTwQiIAmvOuMB8BCfG//8Am
	 nEpH1BeAYWC57sPXQHzD9kKwfqwVBWGDKi92fHejyod3ExbifPZZQcUiq0ytqKlpCZ
	 GX2auvNzlidHUsGJSfW73eJtRnTKLxgfsdflMONLGnnG7XeZ+Ax9h5y29RZsyMN2II
	 zCcGFGSjhfSvCKDrzdwIjOlYvcan9Zam5TaWQmGE+AeJd4ZSUfMq4iwVT90uKqNK+e
	 FxGoVakT8RyAIjGjRlAy/oJZyIIe7K0e48HVphHCQU0+Mhq3jPKpa6yiUx63XllzXH
	 O0VE626CQth5w==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, tiwai@suse.de, bhelgaas@google.com, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com, 
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com, 
 pierre-louis.bossart@linux.dev, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
In-Reply-To: <20260120193507.14019-1-peter.ujfalusi@linux.intel.com>
References: <20260120193507.14019-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH v2 0/4] ASoC/SOF/PCI/Intel: Support for Nova Lake
Message-Id: <176908836249.85917.12484505676319182028.b4-ty@kernel.org>
Date: Thu, 22 Jan 2026 13:26:02 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Tue, 20 Jan 2026 21:35:03 +0200, Peter Ujfalusi wrote:
> Changes since v1:
> - commit message/subject fixes suggested by Bjorn
> - Acked-by tags added.
> 
> this series adds audio support for the NVL variant of the
> Nova Lake family.
> NVL also based on ACE4 audio subsystem, but with higher clock
> rate, more DSP memory and more DSP cores (4 vs 2) compared to
> NVL-S.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] PCI: Add Intel Nova Lake audio Device ID
      commit: b190870e0e0cfb375c0d4da02761c32083f3644d
[2/4] ASoC: SOF: Intel: add support for Nova Lake NVL
      commit: 1800bcdc68ead7209451085431d80aa95ea7cd03
[3/4] ALSA: hda: core: intel-dsp-config: Add support for NVL
      commit: a094d8a50679356fbf045af274ccab85c9a644fb
[4/4] ALSA: hda: controllers: intel: add support for Nova Lake
      commit: 7f428282fde34f06f3ab898b8a9081bf93a41f22

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

