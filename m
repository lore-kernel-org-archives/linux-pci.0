Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEBFC77B76
	for <linux-pci@archiver.kernel.org>; Sat, 22 Apr 2023 00:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbjDVAV1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Apr 2023 20:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbjDVAVZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Apr 2023 20:21:25 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38442D6D
        for <linux-pci@vger.kernel.org>; Fri, 21 Apr 2023 17:21:15 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-b99489836aaso284677276.0
        for <linux-pci@vger.kernel.org>; Fri, 21 Apr 2023 17:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682122875; x=1684714875;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vYPWYGDJMhP7eV/jzWq1VIOUpeyeWw3B0wUE4YZZCmE=;
        b=p/bNplEChqCipEg965Y382pIyekStKKfzL2rZ+r7/98iZAysbEMBPiInYSpDkNsNrm
         hy5DEwvn4duWAUum10kTnlcAZ5P46IFyrAmd9ueWg4yx6XMxKgm7xCadl4M7tgzwLNxc
         BlVKJCZyoA368mMdWudGvnG5OpgrAv5vdCuP6Es4uWT1L2mOhjBilk2EluxX21EsgLR+
         5gLyt3c1/FuX45FtZIUzxj67Mu3ZGqWEOjyFqA9jUxrWHIAPPSw718PlU5P6fpzMUfYQ
         9/KHfk7pIzAOTQfcJrWaK20ufNMW8DSeZ9+jYP6WuMcXX+YjE4ECOYQcFw1EywSzs8ny
         N29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682122875; x=1684714875;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vYPWYGDJMhP7eV/jzWq1VIOUpeyeWw3B0wUE4YZZCmE=;
        b=HKbT2saKWRAUpHg9c1skexbYdSXbgCT5xGkXSOn6P/A+8EIt+0/MDeT2BxMkb7aZTn
         916EEIkaDkMgNx6suKT0pEVjlagBs/C1b9BBt7Ys4DrJUu5FNLXOWkhq+VvEnvM3Yq/7
         4e2ogTJqNyPq0f3MIwDcgTmBGEdJpgrx/wTWakfUcIaTx5NoIvr6bTUemWB4IAEZs/tH
         gcmUTEMGnweYabeA+IBeLvkes2C6VVK6hq5pYz2SkThu7lupmn9ddp0z+23eexDcm7/o
         BD5M/scORl5isRpzuZ2WM8nQU7eUmfwXmVNDiyStME5NamVzQOp+m33nhvsjJZPmXTC/
         6Pfg==
X-Gm-Message-State: AAQBX9cVz+M7Ohu7jJG2QMj7vRYoHWM/EnVtVjNxGYj++C9qMqchkZzZ
        fk9btiZ5lhQ7OaYQeO1qjCC5CoxMEzObR0y6/dT+Pw==
X-Google-Smtp-Source: AKy350Y+lKJO2oSM2BWjg2A3ysf0G4U98qb2g2BmthOtZuVMrE/ho258xSHNWC2L91ksdI74UKOPiSBzxWADWpaq55U=
X-Received: by 2002:a25:e784:0:b0:b96:3fd4:52eb with SMTP id
 e126-20020a25e784000000b00b963fd452ebmr3497830ybh.39.1682122875007; Fri, 21
 Apr 2023 17:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230421124938.21974-1-quic_devipriy@quicinc.com> <20230421124938.21974-3-quic_devipriy@quicinc.com>
In-Reply-To: <20230421124938.21974-3-quic_devipriy@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 22 Apr 2023 03:21:03 +0300
Message-ID: <CAA8EJpr-Xppn0RCOBH-12DJeY1nc5CCgB480FZsrdi4wAY7CxQ@mail.gmail.com>
Subject: Re: [PATCH V3 2/6] clk: qcom: gcc-ipq9574: Add PCIe pipe clocks
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, mani@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-clk@vger.kernel.org, quic_srichara@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_ipkumar@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 21 Apr 2023 at 15:50, Devi Priya <quic_devipriy@quicinc.com> wrote:
>
> Add the PCIe pipe clocks needed for enabling PCIe in IPQ9574.
>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>  Changes in V3:
>         - Picked up the Acked-by tags
>
>  drivers/clk/qcom/gcc-ipq9574.c | 76 ++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
