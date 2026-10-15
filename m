Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B421D53F6AB;
	Thu, 15 Oct 2026 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077776; cv=none; b=WUo3LOevU36A7/81NIQr/STjUZqSGJRw+TLytvm0LOe08E8A/16zmgUpQrP28a6djJu/AVgHH4DLWrhGmRry+kY6HkbQBfAaDD/YeRTAaziZSi6+VRiwx71y6VnUdlJqlvGBGaRVoe7Zv4yplwNZdAzHYc6rwF3lqxWJJd5GHYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077776; c=relaxed/simple;
	bh=2YpI9jVcsBXYCM4XU0pletdCzfsA/GcjSf3ZfsNBPf8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=g3fLNM8wiorw5ThQPD0fb/Rn+36W6qF+je69w6kC4h03fJC4TB5QPvmnkFwLrvHdvLOfHFNbFQsEzYdfWmDCh95ntj+g0ddCH+SRMGfSlkfEDjslLynrK1yd0eUEOg0GlZWNmQd2apN58mg+yuIgrfhZtPmuR+IN74+a30bpqQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGa81SFt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGa81SFt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8E01F000C6;
	Thu, 15 Oct 2026 15:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792077769;
	bh=6w4n9Y2nnDculdbshwjwPH1uLClYOHiVxv4e24nwGCg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=kGa81SFt/pe7ST3DypMaxTsrZ+FApfjn9e6lbzt6CdFDhpqmMS7FjEQo5kR5tmzvF
	 BI5XbvoXuJmL0jyc+M59D1BEaaoyafQp/ZkIfyr9ExH8B4C2GPLKZDpFPLZ29QfGvn
	 plGr0dvUS8hzz3KY+1KIlSAjAQxaAXe4NLBIBXpSEiulzIk/jcI+SUBFbu0Ad1xrBT
	 tXgxobzOg/o7DZMmELjAFaIXyJOkAC6bvidOV3aB0AEUPPtO1Vx1uEbQIfLy1wmZZg
	 IkMx59ncHssZLrNU+bXRQs7WjNVffL6WbFlBB8+ulaWXfcYDPFPVgmtCcuQPpqA77w
	 yBvttOSJFUP8Q==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.Li@kernel.org>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Koichiro Den <den@valinux.co.jp>
Cc: Allen Hubbe <allenbh@gmail.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261015142716.3452900-1-den@valinux.co.jp>
References: <20261015142716.3452900-1-den@valinux.co.jp>
Subject: Re: [PATCH v4] PCI: endpoint: pci-epf-vntb: Track link state from
 both sides
Message-Id: <179207776522.95117.17789668304625324236.b4-ty@b4>
Date: Thu, 15 Oct 2026 20:52:45 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0


On Thu, 15 Oct 2026 23:27:16 +0900, Koichiro Den wrote:
> The control-region link status is currently updated only by
> COMMAND_LINK_UP and COMMAND_LINK_DOWN from the HOST. The virtual
> NTB link callbacks are empty. Consequently, the HOST can see the link as
> up before the VHOST has enabled it, and ntb_link_disable() on the VHOST
> leaves LINK_STATUS_UP set without notifying either NTB client.
> 
> ntb_netdev can hide this device-level state bug because ntb_transport uses
> a separate per-QP LINK_DOWN_FLAG message. Use ntb_tool to observe the
> device link state directly:
> 
> [...]

Applied, thanks!

[1/1] PCI: endpoint: pci-epf-vntb: Track link state from both sides
      commit: f9eabc48327fae33cf0a02a8f312c24505dc413b

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


