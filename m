Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D8B20C463;
	Thu, 19 Feb 2026 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771506269; cv=none; b=p0MemiWQm1K+EAd0q3sj826simPbCNHKCC3GI6dn7YOTAjsHRNJneLirsS5Px/iTBW8FuyA2PmFdfIF/sRV5Vr3GLdiROrHkEPqEAgsIWcEwGwFPgm5gm9IEEXZLrtvt2vm+qgLl5bYI/BRNJGhFUrZxh9FURARU+xRooGWD/uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771506269; c=relaxed/simple;
	bh=YaupYybKXPk8brOSgB4K4h8v8tV/LOUKRVKup6Bhfqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUpTlWP3RUbCZqHuRUQJcZOaZc+zWwUbVmo2BCz/YpXIzHgFUoJkLehh02doBshn1ooNyjTD74DNMa/96pNOB4dT7QnU60YCXgLOw9y+RJbXsP4AmNc/TTPObKm57fRYhD05P1phh+BmDtFgOwqA/lTYCM39I5uTTA6xprP6VfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y02RrbMJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y02RrbMJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A86BC19423;
	Thu, 19 Feb 2026 13:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771506268;
	bh=YaupYybKXPk8brOSgB4K4h8v8tV/LOUKRVKup6Bhfqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y02RrbMJ4BEHjvpBPzELosF1WSulsrklhevqx+3k8uQqGHwk1MG+tYLPTcroZv3WW
	 przOYF9tGvA05dA3xCTXwhmx7fK8z+5Az9348LlKKinBWruLKM+l33FQHV06SzbWeo
	 X+oCo/SNU2LqIWFUVRy+jrxRE+S0TKNlEn9sjzAFHsoEngVlaOcLo4eXJnKBtF3Tzp
	 0WbK+8pvCUuIkbF7tO9iGdhI7KROrTQkMDCrAtgTCgAgCskFaNHlRhzT58U/m/Cjew
	 V5Z5+x1j7W1RY3UaGIe/gjCOQ02KeNDP5UPa0QSxDxOWuT7xYnqxVM4w6/ZGjj8q1K
	 e07H8FyZJQmaA==
Date: Thu, 19 Feb 2026 14:04:20 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Arnd Bergmann <arnd@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Koichiro Den <den@valinux.co.jp>
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: select configfs
Message-ID: <aZcKVLGNSifE60-P@ryzen>
References: <aY7wXJQJsfdqJ4j9@ryzen>
 <20260218180027.GA3435176@bhelgaas>
 <aZbRkXM2vIgAwvzz@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZbRkXM2vIgAwvzz@ryzen>

Hello Bjorn,

Since there now is a for-linus branch, is there any chance that we could
include:
https://lore.kernel.org/linux-pci/20260202145407.503348-3-den@valinux.co.jp/

In the for-linus branch?

Otherwise, the new inbound submapping feature in the PCI endpoint framework,
that was added in the v7.0 merge window, will be buggy with regards to
in-place updates.

If we include the above series before v7.0 final, all kernel versions with
this new feature will have non-buggy in-place updates.


Kind regards,
Niklas
