Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB0DC7619A
	for <linux-pci@archiver.kernel.org>; Mon, 20 Mar 2023 09:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjCTJ2O (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 20 Mar 2023 05:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjCTJ1t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2023 05:27:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DBF241D2;
        Mon, 20 Mar 2023 02:27:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0B98612E6;
        Mon, 20 Mar 2023 09:27:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7C7C433EF;
        Mon, 20 Mar 2023 09:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679304428;
        bh=VzoV8gJ0BND3+ou5PUHHzjX5md7tjkjfvtMfbIyIeGI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kf6nzbduO0QKxjvOJ9kB1OtkL6AKKYIhGpPJqUVKQBjAheZOe8KkyHY/MfPRXiowe
         XkSoNZlHqpdFgZDbP5d9YzwFWXv44j/KIkjnQBQMt+dfgx0pkhpIQ/y45A3P4mQ6wZ
         OZuhlvip+ZPcbVbCgwPJ7xuzSZWOsBbySL85EIduYa+pwo08dVN8/VBHls5+Ip04MR
         LfRheqihkH9fPy/JcQWbumI8k4cJE8QumhU0zuBwhLMu5AXgEbA2WfPyg0Igl7Yrlh
         b81sZ77BidakjiHKhOFQuz3XfwFehuENHjCKXvo76rfX0WpL4WjtE+3XU+zrvcIO1c
         lA6GrmJeOmwxA==
Date:   Mon, 20 Mar 2023 14:57:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@linaro.org, bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 11/13] phy: qcom-qmp-pcie: Split out EP related init
 sequence for SDX55
Message-ID: <ZBgm5zCth1L2pvJg@matsya>
References: <20230308082424.140224-1-manivannan.sadhasivam@linaro.org>
 <20230308082424.140224-12-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308082424.140224-12-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 08-03-23, 13:54, Manivannan Sadhasivam wrote:
> In preparation for adding RC support, let's split out the EP related init
> sequence so that the common sequence could be reused by RC as well.

Applied to phy/next, thanks

-- 
~Vinod
