Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA4B560AB8;
	Tue, 22 Sep 2026 16:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790093395; cv=none; b=UqRCnO2nQJM0cvQ9QPieFOPWiCeY5+y/dCb+uI89QQJHhJbr8AL083HxLg/NiTEDGC5m9puTfhAqjzO8O2IIQxgT6NQ/ThgP/hNyWVraBW2BjJc7ll2tmPp2k+BuWBKSGOUC8gv5jm7WC4YDyrBlX8iuwSDKwIz0Rn4byR+X2Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790093395; c=relaxed/simple;
	bh=gmcmjLXZtGV5GjIMchJUOZ83Hywm7qIGg6SsnTJ0MNo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Qv2ew2vhFpqhz+VfhWyQBu+x5C2KFDrQrssFzzsWjAb4ODMCK2NVmjqr5jUQpbp+jnyiPK0bRTa3f2vWHCigbOYDFw3hWuVwOZz4rLr2v/dsW8BpPz/KXkzgI41CRkwScImFXIt32raWsawH3bZPeCrykJ2lyv6Oms/A5/WlggE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxJjTmCN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxJjTmCN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE0E1F000FF;
	Tue, 22 Sep 2026 16:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790093394;
	bh=DttfrClc2jxogD0qkYNCDlF69QPH9+8rs4HH/0QpjLk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=FxJjTmCND2lWpGe6+UpeqycA/5aY2yeuUL4byA1AaumfIBuWjl55HbJQ8bKj9YRui
	 JPtvfmHPA8M+/KhbkTzFizTWbh4dnMySwscQ1/181lYGd0hF1KHjOds7FOgQmDckB4
	 WkndRLySCl+DeG4o+gVGw+ja9idN0unH4upJB17pFb1Uhea4N0xFRKdEd52ZhkaIWc
	 avWvPl9k1YB6YJaTU58ajvmKw0bypprfNmEzu5iTydbAnKmLFGxwokTCAZBSA4VdWb
	 B/azxXaZmwvLaAr88b+pW9xCeoMacXFQyd+loS6/Bfn8NOlkGNqQ5oP4pmHz3MCRLA
	 gtkzc5OjK4UAA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-pci@vger.kernel.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Koichiro Den <den@valinux.co.jp>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org
In-Reply-To: <20260903205153.283553-1-marek.vasut+renesas@mailbox.org>
References: <20260903205153.283553-1-marek.vasut+renesas@mailbox.org>
Subject: Re: (subset) [PATCH 1/6] dt-bindings: PCI: rcar-gen4-pci-host:
 Document Application/Local register reset
Message-Id: <179009338958.48174.16454140057787464416.b4-ty@b4>
Date: Tue, 22 Sep 2026 18:09:49 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Thu, 03 Sep 2026 22:50:52 +0200, Marek Vasut wrote:
> The R-Car Gen4 PCIe controller does contain core reset, which puts
> the controller back into well defined state, but it does also tear
> down the PCIe link. This is called Application/Local register reset
> in the documentation. Document this reset.

Applied, thanks!

[1/6] dt-bindings: PCI: rcar-gen4-pci-host: Document Application/Local register reset
      commit: 8df20a9670745364b645b3eee0729cdec8766148
[2/6] dt-bindings: PCI: rcar-gen4-pci-ep: Document Application/Local register reset
      commit: 5dad3af6518990506fe486bdf2165f55a86ae86d
[3/6] PCI: rcar-gen4: Add Application/Local register reset control
      commit: 66cbc9ab5b39ff0f4303119e34ebfaf00044b6c6

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


