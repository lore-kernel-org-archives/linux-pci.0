Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C76F1F09AD;
	Tue, 28 Apr 2026 22:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777414530; cv=none; b=oBE+3JlzBrVjQyII/URyjrREp9ypCCJ8/iS87C5KAluQ2dXfZubby23yKXrpzbTAgssdETIGPuNbfMvaodQXho02gyD1AQ5ShqU3ydGZziVPGHVHCtxMZI1kMZeXGsp6kk2AQz9nXEtebiPGEeP/YQCOnrjvgibh2h6n3O8X+bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777414530; c=relaxed/simple;
	bh=U9QH795wlO9OZBECu79uNOFrN9QsvIiWmLQbbXfBAcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aLvaJ4ksf1V6iA2wIM2NqG2vZ9V7N4tDCgFreaGy4+LhOeCEzU7rf8aXiKw4xPuZQEvWM/Ehgu+6+R7KFAI5eIwCPXexlyl/AYQ5QoIra326Nzyque5wN3ZU6Rm/99OJk/SreU7kBqzIIdCcFkTGuiiEKWWFu4MsQEB5+6JJMmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbXkYKLM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbXkYKLM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DA7C2BCAF;
	Tue, 28 Apr 2026 22:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777414529;
	bh=U9QH795wlO9OZBECu79uNOFrN9QsvIiWmLQbbXfBAcU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bbXkYKLMpUWYsIwcthnFHBExqY6Cpln5ltYwucXRfgkEx0ASzs1Hblgp/B09uiyTI
	 ol+RgmqMmKfZ+YOshQj2wm00IcgUhbbpGEYx5v9WkkfyITMDPkQVUEmC8T0O6CkHEQ
	 kO3yCQtomjT6uRl7pZise3QpaLZNwJ5M4/0p8JsrumrBWhgR8g5nDm5S/cZlibZG/m
	 3MqhA+nU8UcBamcLWzB5balBN/7w7kjt2vKkY+D72GiBtvfQaoXa5OMcEqUHsqUhC2
	 PufGmVs77JyFtlM1YRR0SQVOSxjbXJrNXBHisXWXYCvYrxyUk3qIC/dE5LzuVIyD+7
	 XKa92Zz0f1bGQ==
Message-ID: <368f2415-12fd-445f-a1c1-e9992867e45c@kernel.org>
Date: Tue, 28 Apr 2026 17:15:27 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Improvements to PCI hibernate path
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 linux-pm@vger.kernel.org
References: <20260428221243.GA259307@bhelgaas>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260428221243.GA259307@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> It's a fair question.  From my perspective I don't think it scales
> very well for me to go through all the Sashiko comments and figure out
> whether they make sense.

They are absolutely a lot of work to go through these flows and validate 
for me too.  I'll do it; but I'd trust Lukas' thoughts first before I 
spend the time validating Sashiko's.

> 
> The trivial kernel-doc comment is definitely legit.  The others would
> take me significant legwork to evaluate.

Yup agreed on that one too, it's in my tree already for the next rev.
