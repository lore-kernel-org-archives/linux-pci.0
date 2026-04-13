Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438B62EB0F;
	Mon, 13 Apr 2026 20:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776110434; cv=none; b=aHCCJeFh8OZvx6gJPyRgKSWLWGi+2mrFtcmm5BXz7/R0Y4hIqeD2caLQfRxh2qVN7RUdBmEMlGNpPecnqM+FRHg0uT2DzqXbOvUaJq99vVFQVJxD7bat0cIxbuL5HR9t3JMsi542WPmw0Rsr3ES0HXr4VPJPTIUikcL7jdvDfJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776110434; c=relaxed/simple;
	bh=WPx8CTRgamD7KatsZgjeYaW6fnE4s7vStM9CP8CV+IE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lJFJClL7FNhollKltm1lAeQvIcEyGjyS4kiLATHBKYO8divHf7mQQQhLXecqksZ1skLR6k6FHhGI797jWDjk9gC7uphc9HmgtyaPFEUl6O1+te2NPCtLOeadzqhw4Q/AV1DPI0hcy8EtBiVsEgYe3cj9UBDo1C8AfMDjRfvVb6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hof6imjH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hof6imjH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2270C2BCAF;
	Mon, 13 Apr 2026 20:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776110433;
	bh=WPx8CTRgamD7KatsZgjeYaW6fnE4s7vStM9CP8CV+IE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hof6imjHnvBwPjHucz3TrKnjTBAx8ZbFshMolJb5w+YoIoG8O1b69GMHXPVvykak5
	 lQCYx8VRW8gFfzgz5mjGgCHTiuJo7q+helem8yPp0h1rK6zf95KX6OkvW1zBk4h38n
	 XQ2NUxsgxAJCnUVvPYA1IW6tKetA0M8UstIgYWMfgglOMTiEFx2e9oUH1FdaHaY1sv
	 BMFH7CC6taEtbU05MSLrSb58LFbu0dNRU+MkGf7UUDOjQm4TI/XdMk1RatwMkKwDnA
	 dIxcrnNp8YMev8nn/IikNYoIt8zxiOYkt2OkaDynoUqNMB4QW9UgWU7Ka52O5HXtjM
	 o6bOYzdE/HFSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE9B3809A09;
	Mon, 13 Apr 2026 20:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: btintel_pcie: Support Product level reset
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177611040529.523783.435139428854356535.git-patchwork-notify@kernel.org>
Date: Mon, 13 Apr 2026 20:00:05 +0000
References: <20260413042041.1318723-1-chandrashekar.devegowda@intel.com>
In-Reply-To: <20260413042041.1318723-1-chandrashekar.devegowda@intel.com>
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Cc: linux-bluetooth@vger.kernel.org, linux-pci@vger.kernel.org,
 bhelgaas@google.com, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 13 Apr 2026 09:50:40 +0530 you wrote:
> When driver encounters a TOP exception, ACPI methods will be called
> for Product level reset since Wifi and BT share the same TOP. BT driver
> will first reprobe the wifi driver and then reprobe BT.
> 
> Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
> ---
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: btintel_pcie: Support Product level reset
    https://git.kernel.org/bluetooth/bluetooth-next/c/912a499a7955

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


