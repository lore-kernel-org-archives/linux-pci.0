Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812F8423A70;
	Thu,  9 Jul 2026 12:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783600590; cv=none; b=QkN8961YB2fYURUNXj8CNa2g3QDbzhwDQKZNqVKtvFURN7fcRd12QaeskJ0qsFCxBTEavgrTjJETs0lLa2mT9R+y/JEU7k/ImT3+5bS4DZsvAJ2RZIz03aa/nEy9kmwzcMgyzYiQZsp1ShOqidnmIMJEnPwYVusF2WUvs91PFAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783600590; c=relaxed/simple;
	bh=RoLSs1vhcBTsjBE4V4aZnaosHdcFMkPrSdpeiqsAdRY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UusJY5ptpFeMXFCvFCM48cyXRiBd60SKW0lEH3hgrwWkvGghKCpr5dk8dp+RHsf5aBDxMqEuu3DtgiF3rNqS57Z7znx52eOO9RBoH5CYBxYse13Ycy1ki0qlxgaczje28AS+mXV1YfrOzsxxb1RhXoUFQWnxlVuEPsFxGjd01no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWgz5J3g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWgz5J3g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1DD1F00A3F;
	Thu,  9 Jul 2026 12:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783600589;
	bh=p3Hrs6jLxscb7V7lM82CIcgM5oI8D/ykDlnr8c+3vHg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=kWgz5J3g+wImA3C+KVWD6oyNThpoSvC+U02MtUWXj3qqeSGDWyR8ZzbZetFBOdDSd
	 zqePrpvp9ioBVygM05Tz64oNaT5frpeJQuhztczhQKcO6jisWX1zIeoBiZ3ZO/wiQ+
	 mNfIZrSof6/ACCLObOaYWn6BkkI4kzxfW/vj/vrtDHxc0uFRLGuX7dnyMY+Vcr5jkD
	 gYY7p4k3o32skZX9ZVV4kkcazE21//GwNJkHOOHjBakaH6X5cnu7LLHa0KVLQn2Epy
	 goZNMVIg240nodyVrwSqJ5lf4Qk4gYxNVhaETIsgvsXhaoCsT9fZ6aaVN4eH0mAUk0
	 eZuNH+agySNWw==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Aksh Garg <a-garg7@ti.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260704122835.14277-1-pengpeng@iscas.ac.cn>
References: <20260704122835.14277-1-pengpeng@iscas.ac.cn>
Subject: Re: [PATCH] PCI: cadence: add missing MODULE_DEVICE_TABLE()
Message-Id: <178360058575.751615.258668681362535922.b4-ty@b4>
Date: Thu, 09 Jul 2026 14:36:25 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Sat, 04 Jul 2026 20:28:35 +0800, Pengpeng Hou wrote:
> The driver has an OF match table wired to .of_match_table, but does
> not export the table with MODULE_DEVICE_TABLE().
> 
> Add the missing MODULE_DEVICE_TABLE(of, ...) entry so module alias
> information is generated for OF based module autoloading.
> 
> This is a source-level fix.  It does not claim dynamic hardware
> reproduction; the evidence is the driver-owned match table, its use by
> the platform driver, and the missing module alias publication.
> 
> [...]

Applied, thanks!

[1/1] PCI: cadence: add missing MODULE_DEVICE_TABLE()
      commit: 93aac16f1eb9a181f9bdde620b464f6cc5fa8369

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


