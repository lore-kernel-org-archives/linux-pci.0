Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE31B220F2D;
	Fri, 18 Sep 2026 01:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789694721; cv=none; b=u7uU26bcHY+l8BuV/0KchwIFxsxLSQ67vJ6mtMG2jGlV/0o8tOSzjOmmB21exo+PgQVrAPkZ9RdOM1PpMwRG2UoWeS+O59bBjfYyQ+aBF6jq9g+WGVSB+0iAtRQUwqRDuzlQCrx7k5sxuocHW/rAbki/LvLEIoK3TOQ4VBj/LiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789694721; c=relaxed/simple;
	bh=8JPBNZbytwRAcznhLsjAiAPX6howH+VHm2DRTokq9OI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WnBAWN4Ts0kakuyjH81Tmr2L7vz6JthoDawWGwHhu0W6IRQTy16/417kOz5a3nOrb6Jn7oNFIyoHTnZ+SSqKiFrfbu58Nwty21QP+ehVzuo5VjdZ82ywHuLWlVfe7+i+PQIJk+Qd/uqUJv0ilFjOmCnIVipY3P85qElI3FBsUlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IK54zIfo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IK54zIfo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127DA1F000FF;
	Fri, 18 Sep 2026 01:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789694719;
	bh=GqG0imQjJwgGda41eeuJZNGH1mLjywTYU52AO2sACnE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=IK54zIfo00oA8nOCof3BKBRDbYCUIGExUVlPGvkZjuKwQdHYAh8byrlKbgx2568nP
	 donBbKTPRMhWaKgLLxF4gDE1jvo3BuvrEPNyWG1GMO1trO8POsx13ZBX8yOVc57ind
	 Tg11M4gLNuvHaePWSV4lFRzqAYFMskPVWHbHLHLl2KznclCPPDdZwcZOb/lQ8hLgWZ
	 hXm6WXvZYI7/xcDy5WWJSBlIfNxcdi1ouIapoPyKEZVd8zHQwKdZX7DI6b5SA9hHqw
	 ZZ/4ol+O6KPiCH4bTeD4jljpsf9U8mFpigBxZM1kePDZg4RqeaKK6J7bPAQ17URDmz
	 TqtRLWH6KVDOg==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, 
 Anand Moon <linux.amoon@gmail.com>, devicetree@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260902142449.735168-1-thierry.reding@kernel.org>
References: <20260902142449.735168-1-thierry.reding@kernel.org>
Subject: Re: [PATCH v6] dt-bindings: pci: tegra: Convert to json-schema
Message-Id: <178969471460.164579.7468750310934261303.b4-ty@b4>
Date: Fri, 18 Sep 2026 03:25:14 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Wed, 02 Sep 2026 16:24:49 +0200, Thierry Reding wrote:
> Convert the Tegra PCIe controller bindings from the free-form text
> format to json-schema.

Applied, thanks!

[1/1] dt-bindings: pci: tegra: Convert to json-schema
      commit: 94976a87cfc164fdddda54f4baa61ea7f0bde323

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


