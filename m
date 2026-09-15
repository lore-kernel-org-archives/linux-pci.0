Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E03141F5D8;
	Tue, 15 Sep 2026 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789489910; cv=none; b=IXPwbRBczSIKrBpJlBLULNsnfSH/FAesNIXaYURCoc9Evwrx+Tfqz2gB0JKUh8Hyzsj908zyXh9SlfuZ+zsyg6/m746imUntjqMnixH9kpDaxeKQltlMUCioHm8Fx3V2ezhHYZPyW15PjTLLQ05uHhRVX4bKva3zw4E8nPdIpl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789489910; c=relaxed/simple;
	bh=L2hJXONct+LEEUsdtLbXPmTK5byZcDqkWXHtAOPLEaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6x036fGfDbK5a3IRLbfnAuqF+vVaBGdllfdWycdI3Wemi+u39D8rYfc2P5Y6TfGyUtCJYlbKjMXdMdajGWpZjmN2vXdRriMpUqR/n/u+Lgjong7sZgAs2exB5AMfBsQzs2pPRVy0RrAZzaRW6aONeNZSctdPy/eC7vzzMD2XU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1CYhhXy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1CYhhXy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B2D1F00893;
	Tue, 15 Sep 2026 16:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789489908;
	bh=3zRdQW8Z6saeS8gKBcF/+n+daD46YV6VcZbruKzE2CU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y1CYhhXyRIIkIghOTGBORwaPiLZyWvEJoZ77hRnBq4bGi7czswDn76ZzL1E/QXNqt
	 qD5KyyRy+3ykfWc1C1xiYDFSWQASlkQkoHavL/A/4ckSorn2y8mUdB+X3/e486S4sc
	 iG9ZFp0bhf7kjbclOWmk4f3o5QLJsWZIWT/m4/uKuGIYjiCmNEuZk3Gxun0xdxqSCK
	 wKNyE5JzGt7A4WAqsUKp4sX4BWq5+zJwOzIiDpCio+xQ7SZZupSP7VwzAT4bm0yY9x
	 cF9yw4g53gbaruhQx/Jpfx4FOUjozywMCBjDwqlL0kuLEkVwe+GXhNwG0KRjbPyuUT
	 2AgMESm9w20pg==
Date: Tue, 15 Sep 2026 18:31:36 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Xilin Wu <sophon@radxa.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>
Subject: Re: [PATCH 1/6] PCI: of: Avoid config reads for disabled bridge nodes
Message-ID: <r22to3joold7ugzwolni4qahyumcekbyugrl2bms3xmiysqtgo@hu5s3dnyqwsj>
References: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
 <20260901-q8b-dts-v1-1-7de0b6a73d08@radxa.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260901-q8b-dts-v1-1-7de0b6a73d08@radxa.com>

On Tue, Sep 01, 2026 at 04:47:54PM +0800, Xilin Wu wrote:
> The TC9563 PCI power-control driver powers off external downstream ports
> whose device tree nodes have status = "disabled".
> 
> On the Radxa Dragon Q8B, reading the Vendor ID from one of these
> powered-off port functions during PCI enumeration raises an Arm SError
> instead of returning an all-ones PCI error response. This prevents the
> board from completing boot.
> 

Add some more info on why the SError is happening. When the CPU issues Config
read requests to an unavailable port, the request will result in Completion
Timeout as there would be no one to respond to the request. So the PCIe RC will
synthesize the Completion Timeout as AXI bus error and that will trigger SError
on the CPU.

> Commit 1a8c251cff20 ("PCI: move OF status = "disabled" detection to
> dev->match_driver") made disabled PCI functions remain discoverable so
> PCI fixups can still be applied, while suppressing driver binding later.
> Preserve that behavior for endpoint functions.
> 
> For an unavailable node describing a PCI-to-PCI bridge, however, the
> node also represents a subordinate bus that must not be enumerated.
> Check the device tree node before reading the Vendor ID and return a PCI
> error response without accessing config space when such a bridge is
> disabled.
> 
> Functions not described by device tree and disabled endpoint functions
> remain discoverable.
> 
> Signed-off-by: Xilin Wu <sophon@radxa.com>

One comment below. With that fixed,

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Please send the patch separately to PCI list.

> ---
>  drivers/pci/of.c    | 27 +++++++++++++++++++++++++--
>  drivers/pci/pci.h   |  5 +++++
>  drivers/pci/probe.c |  5 +++++
>  3 files changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index a51dff91b196..37e9062065d7 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -24,8 +24,8 @@
>   * pci_set_of_node - Find and set device's DT device_node
>   * @dev: the PCI device structure to fill
>   *
> - * Returns 0 on success with of_node set or when no device is described in the
> - * DT. Returns -ENODEV if the device is present, but disabled in the DT.
> + * Return: 0 on success with of_node set or when no device is described in the
> + * DT.

This change doesn't belong to this patch.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
