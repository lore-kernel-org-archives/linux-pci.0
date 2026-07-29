Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA80473C9E
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 11:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785325487; cv=none; b=LH5XfcTLED5vsLvWO5gQ4U52bk4i07mNSwNuYIXeyyv1etj6l57ZQnpUj8y+Np4w/jhYnLEs5iS2ruGbMBatdZON/VfY3ZbP07UF6/k3JCyuoMytQtLdSj68gVRsIPU/rcAwmiP444WoUCnFqRIYTBINCR+PzS3LLCZJ1Uzdnhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785325487; c=relaxed/simple;
	bh=zCeTVkoANTRIU4f6TWSYpr7Me2LGN6k5XemXao2cqQQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Yo1VssURE6rDkPUI9ksY7lxTvmcKlxXFtuBYWz7GZtOOUSyp2cjeUUtgROElgzMyE4hGRqCcFQwSdgk9iHkdNSTl6Bw2xyWRAwIfgsF7tT1kz2P/hxKcz7BuQ0UjV4KtSgftLxQKkGQ578Du4JxJoUfCr9Rq25+y3xfnDKL187k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD881F000E9;
	Wed, 29 Jul 2026 11:44:39 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: linux-pci@vger.kernel.org, Nirmal Patel <nirmal.patel@intel.com>
Cc: bhelgaas@google.com, kwilczynski@kernel.org, mani@kernel.org, 
 robh@kernel.org, lpieralisi@kernel.org, 
 Nirmal Patel <nirmal.patel@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
In-Reply-To: <20260713220844.561357-1-nirmal.patel@intel.com>
References: <20260713220844.561357-1-nirmal.patel@intel.com>
Subject: Re: [PATCH v3] PCI: vmd: Only assign OSC features in bare metal OS
Message-Id: <178532547982.874721.10693993786129011763.b4-ty@b4>
Date: Wed, 29 Jul 2026 13:44:39 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Mon, 13 Jul 2026 22:08:44 +0000, Nirmal Patel wrote:
> Copy valid OSC flags from root bridge only when OS can provide correct
> values. In virtual machine, all of the control features are disabled as
> hypervisor will not passthrough root bridge information to VM.

Applied, thanks!

[1/1] PCI: vmd: Only assign OSC features in bare metal OS
      commit: 2162572d34c503882e9047a2b07adafd6139dc2d

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


