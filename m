Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41223EC683;
	Thu, 10 Sep 2026 07:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789026822; cv=none; b=b+71ouHkaNlEix3JD0xPv+aLcEInHIHyEWatvV6CxoFnCF4iAudB7l/utRUqOcRiOGJVovA/edryXtBhkYbZg/iY+A8vUBwjdB1/W0rWXa2h9t9AOCZocdPoe+zqMF82LO5XaVSHv7K2MXCogE5qZb4J+tdgDmAcze5zjq+8y7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789026822; c=relaxed/simple;
	bh=Lb763JLAmWQy9eT8v+rsJ/Yd1DfQWRXGh2TljQsYfgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mx1rb0VyCse7ltNqO/5Dm9LiOw1kSKeNZRLHjh4tZ+BaNWLLUWbaoteNZ5Zh6A8c9SbaEDmGSjsFMoGPNZ8yi5OcVbSmHhVPJOMdB3JMSioKrSdRiLP/TN6DcAkNm4gQ1tFsDKQ77M1BrdrnYVpHYZwaM6YT4d0G1G1TLFZ6odw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gT5IlIaa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gT5IlIaa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893BE1F00893;
	Thu, 10 Sep 2026 07:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789026821;
	bh=8GSiH8iBWWjvRBjRlXsDozfrYORLZWIESZDVulaEmQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gT5IlIaa85flw+Z6fPOqWirbC+ux7vTYrFniAmr5Q+3j3J9XudwpLJbPW2u7zD57m
	 I6pT8KqYFz23SnDZbv5eDK+axQBZLrTX6ZRw+ny/EeRCs4UtnnTfq0ok4KFNZKCPRK
	 MGJ+FaDB1TmyOmUaD0gcCafFEVMafw40ZXTuUOKB/2u0JSPKxD5OTbscdkerOE+Dk3
	 WXWIj/+mA/NIKDX4FljRQXRD1ifbveECeeddVuj8s1S9nKaV31/9xdhwrkKaYf/iGD
	 pe2ELvMVbDqKj3Uv5ZoCtpsUSg75RD4MbDJRVQiUafk9hUpm1lgkcAjavif2Rpg0HH
	 Gvn6excUOkGkQ==
Date: Thu, 10 Sep 2026 09:53:32 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	devicetree@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v6 07/11] Bluetooth: hci_qca: Embed bt_power in struct
 qca_serdev
Message-ID: <22crvqe3gc4ui6iiur5u367omrwc5hrfgtd3mcod4tio3ybxgi@twxbmnnpz6id>
References: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
 <20260904-monza-wireless-v6-7-d8c5042b3efd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260904-monza-wireless-v6-7-d8c5042b3efd@oss.qualcomm.com>

On Fri, Sep 04, 2026 at 05:42:22PM +0200, Loic Poulain wrote:
> 'bt_power' is allocated dynamically only for a subset of SOC types, using a
> switch on the SOC type that mirrors the one that follows it. This is about
> to become pointless as the power sequencer path (used by M.2 modules) is
> independent of the SOC type and needs 'bt_power' populated for any type.
> 
> Embed 'struct qca_power' directly in 'struct qca_serdev' instead of
> allocating it separately. This drops the extra allocation and its dedicated
> SOC-type switch, and removes the need for NULL checks on the pointer.
> 
> No functional change intended.
> 
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
