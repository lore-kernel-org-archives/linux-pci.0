Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7386D26E165;
	Mon, 16 Feb 2026 10:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771238319; cv=none; b=iiPuoPUvic4EuSUO6P8fGWIdQqh1iuoNlm8IeKSphgYQZPkDVF0CFGoqyUCVOOLhzT+DC2CoYMq9w0uAfCEgKqG10UhbNqRAgBAX/eur5JvXNtws9mofe/ANXgYYasYQYcAjAAzncLEyEaVA/Z7jLty4UsS3UHSu2DeCXB3IKLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771238319; c=relaxed/simple;
	bh=dB57urtMQzMFe8NbOoBddKpC4zqhyMe6pYuc1q8u1ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZhta70RMDUMfrAtWcYJTjVB63Fl0gADAzVs/TID1hKLnl/wtYOwf8oaGdpDwLqK9IToD9kIndNNtDyvejieBcK4pPcXMrmJCW9sTKRy3pQgeTv/e9M6bj8JXcYUX4/vWIBa1F8D5djM9JAA3TadOLzHSIdt1ndbA/j0vOft/is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Giwx4Qm5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Giwx4Qm5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7BCC19422;
	Mon, 16 Feb 2026 10:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771238318;
	bh=dB57urtMQzMFe8NbOoBddKpC4zqhyMe6pYuc1q8u1ns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Giwx4Qm5jaj9ggYW+CyDD0Q66FDARUJWteWS0G3QSh8qQPTUCQWenaoG6a3l1LkdY
	 +CJZVpmwrkbEZUzvE7j7rEaIo0Fa8neG1ZMCJQuZXbbcwgtFsT0OdXEAVsQdXguM+c
	 GPu6BYB34qJlH3rWW8vaptpPWQqbblJF7Bb1KPmNaOsrrH6junf9osKlmmRt8eg6fD
	 /hoFebG2Mej95pDaip/10hkswUQmEHBSf9R6/SKvgKtHbJtMn7S6WaTZbLYFkp0pvK
	 V/3RANZaXF8O6Auw2bSRdeJ5ApbW7IKOSusZ79hXaNEvZ+j36vD2xoOHcHUqqEYT3z
	 6w5wAzjtUZwbQ==
Date: Mon, 16 Feb 2026 11:38:34 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, shuah@kernel.org, Frank.Li@nxp.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: endpoint: pci-epf-test: Advertise dynamic
 inbound mapping support
Message-ID: <aZLzqk25C9pZVu1_@ryzen>
References: <20260215150334.3391943-1-den@valinux.co.jp>
 <20260215150334.3391943-2-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260215150334.3391943-2-den@valinux.co.jp>

On Mon, Feb 16, 2026 at 12:03:32AM +0900, Koichiro Den wrote:
> The doorbell test requires the EPC driver to support dynamic inbound
> mapping so the host can map the doorbell target address into a BAR
> aperture.
> 
> Expose epc_features->dynamic_inbound_mapping via a new
> CAP_DYNAMIC_INBOUND_MAPPING bit in the pci-epf-test capability register,
> so the host-side pci_endpoint_test driver can detect missing support and
> return -EOPNOTSUPP instead of running the test fruitlessly.
> 
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>
