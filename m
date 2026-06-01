Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ED9368277;
	Mon,  1 Jun 2026 19:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780341007; cv=none; b=N/+fVNcKConzdRiq0gS5D18A0oKD48MwGRGbaas8M2m4P1vzi5PU5sgPK5GiL/tjLwtyh+AE4gVU9qkvDPd9+vedXttQQ4bUsK1PjC60Uh7GjfK7Tg0kZUknptED99WXG6Wr5Bln5NFxu4kbH/+K7L3sWU/ZcW/y1UmeDLabJ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780341007; c=relaxed/simple;
	bh=I7UmvdUjoFLTIC2ZoC5qWyh7MVa+3Unu68oe6fQ7lxM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aeGqW/aCHJ+D///w5X7TeKN/RByaxj1W3OlTBrV1Rq+TYpzqvtxJibweXo/Ck4RJSzF4IBvzgANhnNEXKS/UeakX5nGrDkJIpy57R6RmMJRszp2IYyOyO+3gXRNH9cKVDQlntVm+6STw6qJkvpLCSBIfKUKdFWMWDLzc66Om5Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZogtGBht; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZogtGBht"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCA11F00898;
	Mon,  1 Jun 2026 19:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780341006;
	bh=GngcClpbyWaRvoRhgKSg+ORwyCjQbQVmBCSr0fu2eZs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZogtGBhtz42SAp69NnYYQJUTuKJtzZmfdZCfmHdhRJD7dXyJcSKmrkDKDVCGvhUVe
	 PVyIjSGnW+Wwil0Rh+9zlHDjEtr3VzuG/OmfKQhja9VEWUM42dXtWAuaqwoGJMNP/y
	 A8msXa070gKDOLC1aKO7T2TgVi4tXK3SolEUCNUDxbvXqEB1YmgCmU4vwBhDFlFCn1
	 qkuJMO4OBy21sNRj/3aEmLvBk6rpSUG77HkCiaYYulOsp3hHsfBXeeWhhJHSvLc2A7
	 lU0r86JejD1Wtc8aMsooTt4N9V9paw3bbutukvihWH85vyJOREZ5LTmCoSiFkFNsnH
	 wGJpzwlHQSZhg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A3538119F4;
	Mon,  1 Jun 2026 19:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Fix null pointer dereference
 in
 remove
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178034100838.57646.11704665987158144101.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jun 2026 19:10:08 +0000
References: <20260601102612.2164388-1-chandrashekar.devegowda@intel.com>
In-Reply-To: <20260601102612.2164388-1-chandrashekar.devegowda@intel.com>
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Cc: linux-bluetooth@vger.kernel.org, linux-pci@vger.kernel.org,
 bhelgaas@google.com, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  1 Jun 2026 15:56:11 +0530 you wrote:
> Add a NULL check for pci_get_drvdata() in btintel_pcie_remove() to
> prevent a null pointer dereference. This can occur when
> btintel_pcie_remove() is called concurrently from the PLDR
> device_reprobe path on another CPU, after pci_set_drvdata(pdev, NULL)
> has already been executed.
> 
> Fixes: 8c0693e29dba ("Bluetooth: btintel_pcie: Support Product level reset")
> Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: btintel_pcie: Fix null pointer dereference in remove
    https://git.kernel.org/bluetooth/bluetooth-next/c/2bf22888ea6d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


