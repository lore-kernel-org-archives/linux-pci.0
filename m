Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795069456;
	b=FaA/xof81uqad8EX4siCWgEwYvp4VjMuftujfCSqy9VPHbDAE/vjFUsYSL+UJC+D+YkY
	 iAE6CZ0zGBTMnnfgSGP9YwZ25CGYrslrdRnkcfmCAZd/rfsXPgfwjXonfJ8q3evxeAbEu
	 E5dNVQXqBYIKJErlcdq1VTWzgrtTCMCouvjVCADxVUEfkKgJMfRcwXBJXPQpoloFe4bVi
	 XHViIwQn2rY9n/tWax51RxwBwBVHJyPQRSdbm9gVCyJt8ez3cv/azlaTP302xfpRvTtKH
	 w/ncxbJyTFDNjaWWfo50BrsJuRt0Fk7/I+IZezN39zsDhDEUpDfjsdqLTNH4KxMNyPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795069456;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=DE8O97+cLTb2fOL+TR06WyWM36lYsEezlYTIeuQx1X4=;
	b=OGIstq48ScOkyj+IQ0+YQg1bZ3SbjYJWlt55v939ir/NEyH5yITKu/aN6wMvNZC1590K
	 Nq9Kv+ahU59amZb82ftJkjnTxCIq3rPsg3yuhPmzLN28wymv1jGoGkWSBqrTOmcHH66Mf
	 hzmh2fcUFChMNZTImZ2WdotdW6pDXrDqzDX+k2XAe5RrrLw0OBHVc7FIgCKuBD2dr95wD
	 kjKXRINzvXH0QRLNHVJGgn+ZSg+puwwN1N1tDuBS5Mvsfh29i/bHV8yco1AFSpT0shyY9
	 qtr63PX29sqKeIJYoL6lDgJa9NRIRA5lo/21CK5+SrlwBClxDJAI+j0OxIGVuzeu/9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iav.lv;
	spf=pass smtp.mailfrom=iav.lv;
	dkim=pass header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=DfBt5dy8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.17
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA6C606A325;
	Thu, 19 Nov 2026 06:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EA6C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=DfBt5dy8
ARC-Seal: i=1; a=rsa-sha256; t=1795069423; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=dtRWGpjk7C/pH1f81J5merSCphSkEokQv/E8YaSkNF4k7a9/7qYEp8t960nhaVwg+eTDXlSYWuFXbK9poDVZSQuHwY4HPQka6PxrWpR6SXnzgNUgNc9+CRw/VHis4kjcQnF1/XE3tWxEBxkKCpJG7wNJCbGqlte/CRAyRQN5XD8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1795069423; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=DE8O97+cLTb2fOL+TR06WyWM36lYsEezlYTIeuQx1X4=; 
	b=Ie00+LxniYfy5vjl7DO1UNTBoLmgX48CSWYC8PwVqMag/G4TuzDxYbZVX3UdC4yXe6WbdVccTyBUKfuABcHwBMXrhsR9cqfmkg+vrJQfOASVX9d2pa9BTEH1K4qJIPQYo2XusckmACB+yY/B2X0mKNologMFCW2X2lWDOxcjthE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: a=rsa-sha256; b=DfBt5dy8/PibWVPur2s+Bn5rh5CwcSYwxqhCP3s2WuzOOGnnyNePpGxC8dPueCpaqaRGgaLLNBgI3gcnl8ldp5MxxHGROxl87QvNH5PzJWUaN504uu+fGlMI6HoCyn+YsQtkFoaDY5UzcJC5ZbWhx5FB9IEdYuPcIqa90BYiSRE=; c=relaxed/relaxed; s=zoho; d=iav.lv; v=1; bh=DE8O97+cLTb2fOL+TR06WyWM36lYsEezlYTIeuQx1X4=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1795069422691713.2242534782733;
	Thu, 19 Nov 2026 07:23:42 +0100 (CET)
Date: Thu, 19 Nov 2026 08:23:41 +0200
From: Igor Velkov <iav@iav.lv>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, iav@iav.lv
Subject: Re: [PATCH] PCI: rockchip-host: Support hibernation with endpoints in D0
Message-ID: <20261119-re-anand-rockchip-hib-rails@iav.lv>
In-Reply-To: <CANAwSgRaHubdh8o5Zd3k5Sa_jf5fWuEuCXqbQu7gGL71MwC+8g@mail.gmail.com>
References: <20261119-b4-rockchip-pcie-hib-v1-1-05df24cc77e6@iav.lv> <CANAwSgRaHubdh8o5Zd3k5Sa_jf5fWuEuCXqbQu7gGL71MwC+8g@mail.gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 19 Nov 2026, Anand Moon wrote:
> It looks like we aren't disabling all the PCIe regulators (0.9V, 1.8V,
> 3.3V, and 12V)
> during suspend and re-enabling them during resume.
> Shouldn't we power down all of them on suspend and bring them back up on resume?

This patch keeps the rails as they are: suspend_noirq() already turns
off only vpcie0v9, and the other rails stay on from probe to remove.
The 3.3 V and 12 V rails power the endpoint; cutting them in suspend
loses the state that the PCI core and the endpoint driver expect to
keep in D3hot. Doing that would be a separate change.

--
Igor Velkov <iav@iav.lv>
