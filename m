Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC00375F6C;
	Fri, 25 Sep 2026 15:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790350351; cv=none; b=HSf28iStAmA8YNK6IBi1h6y+qxv7wrPTfMcysgUiVGZLm78kuJULXF9l1n1cxbzlB9kDnK+EdfiKV3l2dINtf6SorpXzQu4rS/0EKAyddFyvGOxC330mCqIOAKSQm8agdugEzNF2qYDRnkB3OFUPAmZO2B9UutTspqssWkEY7gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790350351; c=relaxed/simple;
	bh=NvVGQLydZ3ADiGNqxqvzSYEQ8qjxDbS7YuE+omZBxGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6t4w+tmxduGZJmRbDrxXB7WDqZEZfsufCiEY8xqFJ1QmhsQ0stSI5TDYu5McFNi6Lf4p6AuATKNYhA7rWXH97e7salphB7gyV5n//zVTwELl/tc+DvgT2Wiwd1uz0f8zz0dJ0cZuJK4VseaTB1X78ZTWC2d5ZMUu662gC7Xkkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcW4JHkV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcW4JHkV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8795E1F00893;
	Fri, 25 Sep 2026 15:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790350349;
	bh=ahXr8iYLMCrTGMdibdd3fWSZuNO3BxDrBHng23DkL6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RcW4JHkVjo86U9vcg6YxHgnyKvA+NAtGNMzXx2kZwZhT61+dzlihBa2BiiYS4tflT
	 hfNoJMdMs463BtFOro0ZYKY+ZnrCRINmyRBShwFGHpb84CD0+oMBy/PAS7aIDXlfWs
	 qS8+uTLup22Z+Rs+L+id+G7BXnxrHMLxOAUbbn5A0EKLxHq+v14hkNvw9Eoj0PNR8S
	 tyG8aBVJO7XlE0yHzx7aCGcsAKGGudickvxZBTFGEb7VkNkupmk8180XvPlEkqt5RW
	 zBuiv+NGQ0L1brDt8F/zhWX3t11eXCXOxJoeXNRtfP3wqlf9lWSDJkiDxijAk8KH8h
	 3LjZQnRkM28KQ==
Date: Fri, 25 Sep 2026 17:32:13 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/6] phy: qcom: qmp-pcie: Add endpoint PHY configuration
 for QCS8300
Message-ID: <tdzyms6ci25zh2sxthg3khyqjvqpsnhpciqmjmbsj5hnzc35er@5fjuieis44ca>
References: <20260921-monaco_ep-v1-0-63c5282fb0db@oss.qualcomm.com>
 <20260921-monaco_ep-v1-3-63c5282fb0db@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260921-monaco_ep-v1-3-63c5282fb0db@oss.qualcomm.com>

On Mon, Sep 21, 2026 at 04:28:14PM +0530, Krishna Chaitanya Chundru wrote:
> Monaco supports PCIe Endpoint mode on both PCIe controllers. Reuse
> the existing SA8775P Endpoint PHY programming for the 16 GT/s x2 PHY and
> add a new 16 GT/s x4 Endpoint PHY configuration with the required RX
> tuning parameters.
> 

This sounds like the PHY init sequence only works for Endpoint mode. But the
sequence looks to be common for both RC and EP, even though it is only tested
with EP mode.

> This allows both Monaco PCIe controllers to operate reliably in
> Endpoint mode.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
