Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A964C397694
	for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791798108; cv=pass; b=K7Z8x7jVVgomW3v/B+F9vbGaPcrCtXl8GuC/+PGyi+kTp6BmGqj0fMfvKDo8I12GJeoLHXrNmjG5iyaEUvSgGkospRTjUZMvBvMBGuzu2hAwKk2huK9vVSvDzFMWAs87Oc6NPg4MFvnvOHPSCJfhMYIwFyY4j7R/o8el/ofBWCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791798108; c=relaxed/simple;
	bh=xEje11MauacCyql/+a8TCVSQ59zjM7UA50aHu0/0fM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tUWZOe4s/6/FlQWEzFA/EW+O2fW9OgdrYBVfVrTYT56OFpXC4pvGARPf35n0RsFg46+mXRIQ+qJIeIKI+CwmiRt8L+Nz5Y2AMGqWug4gH4BVoTF/Pl8r2UShQRR4W4Orl+FC+t69+NPdwlz4Bd3lVMvI4ue/4u1mXiaisHfOVx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuKKuUMK; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuKKuUMK"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d6e954afbdso6592415ad.2
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 02:41:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791798107; cv=none;
        d=google.com; s=arc-20260327;
        b=bZVqwNgP6762xImsFoWRalYVtDRauqMIXp6L7jFW1Bm/EGBeeOpmTS5ifjzMA79YH6
         5ycgZssZfwO4y+NxeOPjSL28tDKyqPurH7EE9ISpIlCdemTec1lndQokfjiIlH3xZ7o9
         VVL8ixRpcaSo+Tv8khwoOduFJQ5TxlDuxSsdo2wO9VJINB6IbxYu1HY4pOd43l6J05++
         BE4gbohzs84DtyPctj72nHPQ6OMgNMz+Z88mDwf3CwUz/uKo5ypGjnbrI5VpgK68hf3B
         G16nMJKkS7CpPkSOXCmMaGp46JfmY6vvzFXRq7NHX8bAq6ZX8rUmO/M+CGPR8mhmedaS
         nL6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xEje11MauacCyql/+a8TCVSQ59zjM7UA50aHu0/0fM0=;
        fh=zAZRYpJtqLMf3JN1O+EnvXLIElkmTFdODC0BDHNY5t4=;
        b=hRA9xVcKc92nN6blug+erhM0QYgRVb0DJKSjLjiqWDTGLO9aDyvRaeJKbuU7tY7pSu
         qgsLh0Q+x1C3af9ad+kXcCbU9yVpsPrPnqx1COagfsIRKGjXyRZ0VW6RZFoJh6GZbOG6
         zxt9/2ksSfBPN0iaEVvHAB3Xqs7yAk7cgf0iiaqnLjLhheuM4/YKGspxLaMpR1M/Bmbd
         Bq5KxxCRDwzwA70dTEvfTuykh/BVdKLi9F/A4ordLmQ4+fNRmQrJMZgOqJlI+BT2bPqW
         eRGSoeE4ZiJFGtMGBpeUzx5ivPjURoqdfghK2DO6CtFb5SpL4jGlmqruvfV99Y4QJk24
         j7FA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791798107; x=1792402907; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xEje11MauacCyql/+a8TCVSQ59zjM7UA50aHu0/0fM0=;
        b=PuKKuUMK7FCJUAqsNN/uQwQCgRErWKIhsMxoKp882vmKUQTdu3xdKt36TnJZsiHhOS
         cJKJRAEqgILInj2M2mXOQoB+SCen3fdSti0NwTTIH2ISuBcZcLSsAp+yFpSSpAc/+zvT
         y6wvcoe7OQi/KmcSJ4MATVjHHidXPMIU6TTiFT+m7aL5YqWWMAFqZ2cDgk+AuTgChUm0
         rAgbdsAN8tc/BIctNRK6Of8M2zROy+/LfhJfZTzthlYFgIWfk4PQ+oHzHtCC/YiCF9v9
         EGnkhgvEmlz95jpsmsiU20OUfMXocVsGtKmFE51uAUT5A8HA3j5anP8bpRA3KuqsAsk7
         q0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791798107; x=1792402907;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xEje11MauacCyql/+a8TCVSQ59zjM7UA50aHu0/0fM0=;
        b=dNcD8qK6j49e/TvAzWkTP1s13zEtOBNaMJGKONIm9iz6+YSkzH1O8QDlkoCBVg5HOi
         ap+CBNducna45Ae9Vmh9mVoXugeZ3vKkS3Nb23X/awvE15dGbI44El7oVLH5xRUrC9RA
         4ju8Kyq8YZQ7smIur7qtremxamkp5rHa5DEQCE36nasEF7go/O4wzMhcGUTIrzvHnoyU
         egNwkZ3b0IlqHDi+lENmNI1HKAN5AzzO/ruEgfpfpt6WQkH+ddTVdtEDLe9lZ8/Y633I
         ZeXqoWDyMg86C3vt5DBGe4fkCv9l8aXxP0vgGx47w2RWkNS+3NrQVKHcvxlvAUSxu0gp
         TWWw==
X-Forwarded-Encrypted: i=1; AKwUvBz3j0G9dNB7r+ydAh/Y9hh2Jn0b7DIFJZz6+1eiJV8vvjiPH9mDtIUNL9hDnO07USaZG+UdM+BiqL8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKu8YDpVIGgf4pXDDICW7bGNjUsEHgWj6+x2CJWcx3yaEOgvUKg
	+cJuspunn9ubPLX4gpOZGp2ssdqSRxFaMKMI9X05scSGoqD+QuQbNNbSRivoG/3WCdDRyj0lMuA
	SQUVsqf0k/gp4eRB/8TwfwesUQ3RGAbA=
X-Gm-Gg: AYBFou3AEeed9cOuVTgazgEWxxTAKYRpglzakTIEzfY+5uvn6iIma1NLbIKSTZHfcYg
	9oYhtQmF3eDVfbtvB29iBAdPH9lvnCPC13GVfn0UUPwaRt7ofYUNG6DSwCl9tmixPBAzwUAMA1Q
	2LTShvt58dUiCUCBCIIs8UQxKbPp3XUjJFHQi7LXvS4a0lIVALdyvw5ge1EcJRIIZH6AGfX0Ur3
	gg40+DoY55QCaGvQx9duEFo5jVvqb32yswxlTOAFl8F5q3N0R7hqvrOA/BSLarkFwJC4rtSeAIU
	qGsuNl40ZcR+vpQqnZlj9udPXEMaJ7BH0fT9+aic04rvoaTsyr+aFZPY17jjXurlWDi1B5hpO5D
	NTrp7MV8Hlt4jm5tboE9RavZflhuXFrlGVesfBIMpCSxETbrZovSeBixw99ztqlX+Q3g=
X-Received: by 2002:a17:902:d2c8:b0:2cf:afa5:b19a with SMTP id
 d9443c01a7336-2e842ab812bmr74647105ad.11.1791798106721; Mon, 12 Oct 2026
 02:41:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007104847.507776-1-phucduc.bui@gmail.com>
 <20261007104847.507776-2-phucduc.bui@gmail.com> <923d7875-69f7-4c87-869a-fc66727c70a8@nvidia.com>
In-Reply-To: <923d7875-69f7-4c87-869a-fc66727c70a8@nvidia.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Mon, 12 Oct 2026 16:41:35 +0700
X-Gm-Features: AclHuK--qfWr1I67rnpFbrjIRtXfOWVmS6fI1rNM14DuFuibSj-EIqraNUcYF84
Message-ID: <CAABR9nEk0dm4Lghcp8-ej=-0jAUFqvi0dYBBEYg3uY+6YdEZ0g@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: tegra194: propagate REFCLK select GPIO errors
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: Vidya Sagar <vidyas@nvidia.com>, Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, kwilczynski@kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Hi Manikanta,

Thanks for pointing this out. I wasn't aware that you had already
posted a similar patch.

> I published similar patch
> https://patchwork.kernel.org/project/linux-pci/patch/20260923072237.1139013-2-mmaddireddy@nvidia.com/
>
> I am OK if this patch is merged, I will drop from my series.
>
> With the subject line capitalization style fix,
> Reviewed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>

I'll update the subject line capitalization and send v2 shortly.
Thanks for the review.

Best regards,
Phuc
