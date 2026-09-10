Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0A53C3BEF;
	Thu, 10 Sep 2026 07:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789026873; cv=none; b=oK0zjjExpybn0l5/JjQUkQ2R2c1Fj/tPtHGFOm0B5TaoKsmjrSrWZcU27DM3muP1hwnhPEZC8XrtbSBTsz2O4ta2DjAM/bpTsJUzeSzVLKA6q1nYFUyjZrnRd4K5g1nkuvdL3NuZHfj7yRZ/X1/iHuKk1hQ/0FmJ/YfQXK7BLXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789026873; c=relaxed/simple;
	bh=wzYVt6KDz257EJoSY7Xa7I1AGsh1VYvqFP9yNZe4910=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZjR4Al0y86fDH0aYwDBnbo+9XLmjEQWGy1BQ9t5DoyQhH1KrgS3QERIMfJJE6HxrQY5ubN+RWOu9JxRrzjuNVFGidIuLD7SDpVWiOusMzZ78aG7o8mZ8ZKY3JNGqLoyhzh8cpF4m7jyMHNIvXIs/cyCRiKdr0jzYVQz9QrvxJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCy4zQcB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCy4zQcB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998011F000FF;
	Thu, 10 Sep 2026 07:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789026871;
	bh=kyAcgB3Yhj5yrKLfhRmq128yyl1v+dK+FKkCGLeuOdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fCy4zQcB/Os3IU73rIuJJmO6buBTOCi1AkcEK97Jn/qdgcDVfVu3VWuGn4JJIaHZE
	 vbdfY8EFDThc+boKAmlRvbLZH7BafOJUNCDFLNKkxXLnBjk4QYr9RvhVbJe5OvQcOq
	 gFbg8bDQ9ZOlS9RNE8/0fYFXrgBxmkMtwLFakPWZr48db20YxA3LTS6plEQREU5K+g
	 EvgIccdFtZktlrx6UNADfH3XrhYecOk+K9o5bdEKHqrx3kHDNQLbxI1gfIfRSCXbV5
	 3QQWBoYrDH5aeoZ8PxFcvg5haukMizkyk2kGhXDduXi2lgTiimYwXqIDpJ78s5vHmA
	 v/U9PT8CyT9RA==
Date: Thu, 10 Sep 2026 09:54:22 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	devicetree@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v6 09/11] Bluetooth: hci_qca: Flatten struct qca_power
 into struct qca_serdev
Message-ID: <tccqoknfwlqjwro2tzka5aka44xjdmjf236nw65evjvamfwhzg@x7explkeafvd>
References: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
 <20260904-monza-wireless-v6-9-d8c5042b3efd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260904-monza-wireless-v6-9-d8c5042b3efd@oss.qualcomm.com>

On Fri, Sep 04, 2026 at 05:42:24PM +0200, Loic Poulain wrote:
> struct qca_power currently only groups a handful of fields
> (vreg_bulk, num_vregs, vregs_on, pwrseq) that are exclusively used
> from struct qca_serdev, via its embedded bt_power member. The extra
> indirection level does not provide any isolation or reuse benefit,
> and just adds qcadev->bt_power.<field> noise throughout the driver.
> 
> Drop struct qca_power and move its fields directly into
> struct qca_serdev, updating qca_init_regulators() to take a
> struct qca_serdev pointer instead. No functional change intended.
> 
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
