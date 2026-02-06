Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D700027603A;
	Fri,  6 Feb 2026 15:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390349; cv=none; b=We0dhDD8KU9wMsUdyYulJF1hBtCTDsgu1LMbFsyVcKJkirCLr2onL9c519Pa2zBjrd6qNuv7taitHfoIe5TwC07zxBmMhFYoyIT5Q5bP/0F9FtLiKUlrjbP7/Cz7dV+D2l2TGf8fQmB8Lev/ZiTVzk7R6HlK9wkHD6IhQTBOa0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390349; c=relaxed/simple;
	bh=RSB2OFRe/6/DcmzMzPHjQ+Zxxl5zXroyGePOEXEehJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmDqz7kSSCnKKMtHaYc7Jx19l3kd/qMXDIXFmVoJX6mh38D3e+M0g7h2V/lZmzSv8kasoD45yPptgxp6NhQcVSnsXqvtgCBitvBc7T9IKu7PMsfyr0SJd+dynM/bmn520SKyF4L/LpsXRiM+ylCytqQTPxHI5hk83Vawz4E66aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtS2+Nxh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtS2+Nxh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D9CC19422;
	Fri,  6 Feb 2026 15:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770390349;
	bh=RSB2OFRe/6/DcmzMzPHjQ+Zxxl5zXroyGePOEXEehJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WtS2+Nxh55Adz0xYAf0PByzHQ6s6C/C9nq7MaYSOmHTfvsrH8peYshYKPMR1av/A1
	 bNtZxlPTieyMxfR/oUu5tYkKnM1Is7YF8E5Q93LLJOhVIjLIrIdEVROjTAsuWAy4y1
	 9YoxCQ0RJ2aWs9mpAH3fcLA4Bs9y6S80h01srWvaXtE64Aql6ya84wwWDzlQJCEeAA
	 +Z+DungMjosbrvE1frGGvt8dtQQymTMVYPUD1Yt110TpF2luyRzlCdXd1X5r+3att/
	 00dT60TBwiYTA5pZn848oEaCdRoJu43Or0HnQHzR7v8CMQhax8JYjn/CwmABdevwNK
	 OF6JMHeAFfEqA==
Date: Fri, 6 Feb 2026 09:05:48 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Dmitry Baryshkov <lumag@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-usb@vger.kernel.org, linux-pci@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Bjorn Andersson <andersson@kernel.org>,
	freedreno@lists.freedesktop.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Airlie <airlied@gmail.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	devicetree@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-arm-msm@vger.kernel.org,
	Konrad Dybcio <konradybcio@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Sean Paul <sean@poorly.run>, Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v2 5/7] dt-bindings: arm: qcom: document the Ayaneo
 Pocket S2
Message-ID: <177039029875.225465.9560671235103288038.robh@kernel.org>
References: <20260127-topic-sm8650-ayaneo-pocket-s2-base-v2-0-c55ec1b5d8bf@linaro.org>
 <20260127-topic-sm8650-ayaneo-pocket-s2-base-v2-5-c55ec1b5d8bf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127-topic-sm8650-ayaneo-pocket-s2-base-v2-5-c55ec1b5d8bf@linaro.org>


On Tue, 27 Jan 2026 10:57:32 +0100, Neil Armstrong wrote:
> Document the Qualcomm SM8650 based Ayaneo Pocket S2 gaming console.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

