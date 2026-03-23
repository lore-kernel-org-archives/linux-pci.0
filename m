Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7C137CD40;
	Mon, 23 Mar 2026 21:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774301935; cv=none; b=IsDLBxuY2s0hiNLmWDnSRjHzA5c4l6Fcp0diL4zbPsm3nI7QnBMZV354/yqRo7COVXeOBZaB4Ejj8HeERaXHH2TJBppkIrstWHnN2iOg7PgJ97EG6iYXX6OztNxlxPWfOZqZ5XZCvNxEhnrGjtEqOwXuW+dNnLGT+vfbEP9tNfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774301935; c=relaxed/simple;
	bh=gAjYYf3hRs5vi0OKE6ikZD9bVDTcKqaoB+grQvL90TU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bMpz/CvvZfKA9atnvN5nzS5BZNH53BXkruBeVeJIv6DH0CnHO/npCMPqmPPRj+TPLIv5s323qugwfusuPc5VXm9TU/BrxeRZXujHSh6hsj28FaKzKdlHYx3XEbZApl1m0TxdF250Wb6GzKacZkwqo7vLTC5wGVkVxfb3LJryXW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9SsEylf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9SsEylf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50190C4CEF7;
	Mon, 23 Mar 2026 21:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774301935;
	bh=gAjYYf3hRs5vi0OKE6ikZD9bVDTcKqaoB+grQvL90TU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=i9SsEylfmybUGpWnTHIKaIPZbTnAyhfDzNDlpBqstx+yFvzpyb6AsTXIO1fr0zYaM
	 PVxQPkXLPsmWkbBC8CUxGi7Ug1GALNpDFjybqmvk/7B53kKLZR7KoGA9HJgzJ9Xya4
	 5dlc5afRO/J7dpWYhGrNTHhmBY4GG7wVW37Uz5efYhe99n7B8nk09jLqG2r1oDOWB1
	 JSvIchf3ioKsRJ8S6xxZugbLNWN1bP+3yi3yddVewP00XFUsWu/X4rp2NZk8LQqd4i
	 A5jRK2AvE1PNzpMpKbJ44bcMFDo9xPtJS02M66hn/Nve6BrgjupAD/SE+yjTuD0E4a
	 8mJrCYfK6P4LA==
Date: Mon, 23 Mar 2026 16:38:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: linux-pci@vger.kernel.org, linux-mips@vger.kernel.org,
	naseefkm@gmail.com, ryder.lee@mediatek.com, bhelgaas@google.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	ansuelsmth@gmail.com, linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: mediatek: Add support for
 EcoNet EN7528
Message-ID: <20260323213854.GA1082060@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320094212.696671-2-cjd@cjdns.fr>

On Fri, Mar 20, 2026 at 09:42:11AM +0000, Caleb James DeLisle wrote:
> Introduce EcoNet EN7528 SoC compatible in MediaTek PCIe controller
> binding.
> 
> EcoNet PCIe controller has the same configuration model as
> Mediatek v2 but is initiallized more similarly to an MT7621
> PCIe.

s/initiallized/initialized/
