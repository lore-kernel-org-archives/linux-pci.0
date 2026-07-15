Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D662E7383;
	Wed, 15 Jul 2026 13:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784123280; cv=none; b=HagaZROObTJLJkAnDJIm2qVuXs4BNYO0MjbDJAAcLdvVDQo3rwpc9yJvi69r+8vePE557sgM4s/Ol7uNJZFx5Uz6yL/yWSu4IZjVZ6YpGYvogfgX5JgjLa8xdKVZWY/yOEq8BIwwnrwkKD9fkNmj72N+G2P/uq0V/1BuQt2d8/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784123280; c=relaxed/simple;
	bh=OQzA91rQ8Z8Mie6XKaBOl7Ilkn6cZW3b9O+wOXy9QFo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=srM9gZJqOY/kdjxYlNp7ZYb5Kt8s5jK8WWIS2+XmBhqR8PYP/i3gv3CCd1V41QRecqIXbT+fj+i8uPUgTH1KjucifCMG92VaBiIqe1ehWUTb9kISjs6V61ZZAu6DTRAzEWamHNqOJcpTKyVoEFXKTZybnsAAX9ZW1rsTw7qFyrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxMpGCtZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxMpGCtZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED7B1F000E9;
	Wed, 15 Jul 2026 13:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784123278;
	bh=MYWtrnA64enkyD1F8B0IP3sVx0898upZSmCQffKhadQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ZxMpGCtZKRsLLteM57AhHKYnvv3wsGbatlI39VfYS+QGO4jl6EmU0Qt1yNac7NalV
	 92DZJFdnOxQYDoN6OWn3sD0wlQKZipykkuFR0R6kHKUpK2qosdZtNa68MLm+D2CD3O
	 KVTM38+ghTLnda2PxQqNWby+Ap8Y0kbEaH3Zb7K4QqtNQdJZ4aZ0ex4soEolyfcY3F
	 ns6uwl/COnAN+MXf2wrO7YTMrezPbAv7c3tC+jtHXH9myxA1ycdVGA6e0URYttyBXd
	 Q2Ou1rHTd6HmWdBeCvFPYYu6RmS5F10ao9FdmVBg1/rEpnJziqOctuf08zc/TfgNJN
	 b65g6+HbAVPuQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jianjun Wang <jianjun.wang@mediatek.com>, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: kernel@collabora.com, linux-pci@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260701-mt8189-dt-bindings-pcie-v1-1-7c7a65087654@collabora.com>
References: <20260701-mt8189-dt-bindings-pcie-v1-1-7c7a65087654@collabora.com>
Subject: Re: [PATCH] dt-bindings: PCI: mediatek-gen3: Add support for
 MT8189 SoC
Message-Id: <178412327376.143779.2537053670483422088.b4-ty@b4>
Date: Wed, 15 Jul 2026 15:47:53 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Wed, 01 Jul 2026 17:27:36 +0200, Louis-Alexis Eyraud wrote:
> Add compatible for MT8189 PCIe Gen3 controller, that is compatible with
> the one found MT8192.

Applied, thanks!

[1/1] dt-bindings: PCI: mediatek-gen3: Add support for MT8189 SoC
      commit: 068601b547da091d9f56131cbb25e40ad40f4825

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


