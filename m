Received: from sender5-pp-o94.zoho.com (sender5-pp-o94.zoho.com [165.173.182.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA854EF12B;
	Fri,  9 Oct 2026 14:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791556929; cv=pass; b=TRrbpl8VIBW7gZD45ITR96duJqNFmpM0+vTwOZJ8ZGYZ2nxRWN8bRWzTZgVNW9n6sfyUxPZGZCLcFsrrVQLThllnnK3bXoL7NKfoVIN1ZgoO6+7/i9+DOsuklDpUXjKz6sYCuyJ/DDqJM6Io9K9ri26gW3tLtJIzy+nrpUkXLQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791556929; c=relaxed/simple;
	bh=mYcjK8jdNquyn3c9F7hmZXqlaGCNSUvqi4l3YYKSkmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=USOusjl/HOZhLWFiTCkgejCSSpRGMdqOIhgS8dd/pF2g966Rk+98XeHZEAnUmc88DhoNObR1SkItZVpSIC4AXuGfi+viR1Hevazrl4SaLh1jtMWvvYNLVFYkCxEGY9d2sLLY2Gno3YErDVkdG7dOF/1bV5/w8nBWN3wLFWxUIMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=SSFhCZXl; arc=pass smtp.client-ip=165.173.182.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="SSFhCZXl"
ARC-Seal: i=1; a=rsa-sha256; t=1791556910; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Y0h0RXda5FoVKNnqBzy3RMEZyhyvE3VKof3yZ0LYWMCZOeMTM7RySBFplfwSjQkRpo4u1a35oPAzeujo/yxdWhH/0NySCexELMRDawLyM+UvX43Ek5XSeo5yhTW2U7JvWF3DsDDAQnXXzdQTmbHC3lwt4mk3aOQWQXqSHIhQNv0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791556910; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Vc4shJ7JTOZtXqrInqhmldF9QJjIS9vSgJN7sr8S+0E=; 
	b=Msh/Nsj+QAvfujJ3S+YSQ9kIEuHxfDwFg6MzKCrGb8jqiNa/R2Ed6KtmHzDf0gGUTQPdtHc9WcfKeTb6qfm2IalFR9InIeQkAyV00mcfUBD3XtyMuqSbJHSsjKFDacJrIF69S93plrzAYt+8T186jRB0uh2E2QLAHtMQ0oWVKG0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791556910;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=Vc4shJ7JTOZtXqrInqhmldF9QJjIS9vSgJN7sr8S+0E=;
	b=SSFhCZXlpjxpCqZ9MJqji1u4CUiqyE+jRYuV29NP3Y1RFOV5FdU6i7PGeJsRQxyN
	s84R05vl/vvwhI+0jhQfiqGMaUZyrSL5Aw6xmMWGNRx3D58JoMuirXXx7bjw+L3GqJ3
	FN1e0+hvfU5diM3ta1VOT2vfATvA2ews+Flh7puY=
Received: by smtp.zohomail.com with SMTPS id 1791556909356350.57764764958677;
	Fri, 9 Oct 2026 07:41:49 -0700 (PDT)
Message-ID: <3c6f75c5-f559-4b73-a835-70ea3a680fe1@zohomail.com>
Date: Fri, 9 Oct 2026 22:41:33 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 05/16] cxl: Introduce reusable HDM decoder settings
To: Dave Jiang <dave.jiang@intel.com>,
 Srirangan Madhavan <smadhavan@nvidia.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
 <20261001092227.3004747-6-smadhavan@nvidia.com>
 <60dbd245-0b16-4c4b-8350-26570916ede0@intel.com>
 <12dff52f-61fb-4796-afa9-0e7a8f74452d@zohomail.com>
 <e8ee0949-90b9-4572-869d-61b4073c568d@intel.com>
 <f3c0fd73-c9e0-4b65-9f83-2b1fd9579dca@zohomail.com>
 <60653fdc-2b9c-4f9d-841c-6d7d68d51ed3@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <60653fdc-2b9c-4f9d-841c-6d7d68d51ed3@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu080112271575eab0932f54156237566700003da1a77b021e8211d00f34ef2d19d6c8cc498a068694a168af:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/10/8 23:19, Dave Jiang 写道:
>
> On 10/8/26 6:18 AM, Li Ming wrote:
>> 在 2026/10/8 00:23, Dave Jiang 写道:
>>> On 10/7/26 6:12 AM, Li Ming wrote:
>>>> 在 2026/10/3 03:59, Dave Jiang 写道:
>>>>> On 10/1/26 2:22 AM, Srirangan Madhavan wrote:
>>>>>> Represent HDM programming state with struct cxl_decoder_settings and pass
>>>>>> it to the commit helpers. Keep endpoint skip and switch targets with their
>>>>>> owning types and flatten them only into transient programming settings.
>>>>>> Place flags with the programming state and leave runtime region ownership
>>>>>> outside the snapshot.
>>>>>>
>>>>>> Separate commit initiation from completion waiting so reset restoration
>>>>>> can reuse register programming without changing normal DPA-lock policy.
>>>>>>
>>>>>> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
>>>>>> ---
>>>>>>     drivers/cxl/core/core.h |  3 ++
>>>>>>     drivers/cxl/core/hdm.c  | 82 ++++++++++++++++++++++++++---------------
>>>>>>     include/cxl/cxl.h       | 10 +++++
>>>>>>     3 files changed, 66 insertions(+), 29 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>>>>>> index 983d7690c3a5..a3fddb2bed63 100644
>>>>>> --- a/drivers/cxl/core/core.h
>>>>>> +++ b/drivers/cxl/core/core.h
>>>>>> @@ -139,6 +139,9 @@ struct cxl_rwsem {
>>>>>>       extern struct cxl_rwsem cxl_rwsem;
>>>>>>     +void cxl_commit_start(void __iomem *hdm, struct cxl_decoder_settings *settings);
>>>>>> +int cxld_await_commit(void __iomem *hdm, int id);
>>>>>> +
>>>>>>     int cxl_memdev_init(void);
>>>>>>     void cxl_memdev_exit(void);
>>>>>>     void cxl_mbox_init(void);
>>>>>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>>>>>> index 9e05032a5426..d3f21dfda146 100644
>>>>>> --- a/drivers/cxl/core/hdm.c
>>>>>> +++ b/drivers/cxl/core/hdm.c
>>>>>> @@ -707,7 +707,7 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
>>>>>>         return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>>>>>>     }
>>>>>>     -static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>>>>>> +static void cxld_set_interleave(struct cxl_decoder_config *config, u32 *ctrl)
>>>>>>     {
>>>>>>         u16 eig;
>>>>>>         u8 eiw;
>>>>>> @@ -716,12 +716,12 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>>>>>>          * Input validation ensures these warns never fire, but otherwise
>>>>>>          * suppress unititalized variable usage warnings.
>>>>>>          */
>>>>>> -    if (WARN_ONCE(ways_to_eiw(cxld->config.interleave_ways, &eiw),
>>>>>> -              "invalid interleave_ways: %d\n", cxld->config.interleave_ways))
>>>>>> +    if (WARN_ONCE(ways_to_eiw(config->interleave_ways, &eiw),
>>>>>> +              "invalid interleave_ways: %d\n", config->interleave_ways))
>>>>>>             return;
>>>>>> -    if (WARN_ONCE(granularity_to_eig(cxld->config.interleave_granularity, &eig),
>>>>>> +    if (WARN_ONCE(granularity_to_eig(config->interleave_granularity, &eig),
>>>>>>                   "invalid interleave_granularity: %d\n",
>>>>>> -              cxld->config.interleave_granularity))
>>>>>> +              config->interleave_granularity))
>>>>>>             return;
>>>>>>           u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
>>>>>> @@ -729,10 +729,10 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>>>>>>         *ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
>>>>>>     }
>>>>>>     -static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
>>>>>> +static void cxld_set_type(struct cxl_decoder_config *config, u32 *ctrl)
>>>>>>     {
>>>>>>         u32p_replace_bits(ctrl,
>>>>>> -              !!(cxld->config.target_type == CXL_DECODER_HOSTONLYMEM),
>>>>>> +              !!(config->target_type == CXL_DECODER_HOSTONLYMEM),
>>>>>>                   CXL_HDM_DECODER0_CTRL_HOSTONLY);
>>>>>>     }
>>>>>>     @@ -764,7 +764,7 @@ static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
>>>>>>      * clock skew and other marginal behavior
>>>>>>      */
>>>>>>     #define COMMIT_TIMEOUT_MS 20
>>>>>> -static int cxld_await_commit(void __iomem *hdm, int id)
>>>>>> +int cxld_await_commit(void __iomem *hdm, int id)
>>>>>>     {
>>>>>>         u32 ctrl;
>>>>>>         int i;
>>>>>> @@ -784,45 +784,66 @@ static int cxld_await_commit(void __iomem *hdm, int id)
>>>>>>         return -ETIMEDOUT;
>>>>>>     }
>>>>>>     -static void setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm)
>>>>>> +static void setup_hw_decoder(void __iomem *hdm,
>>>>>> +                 struct cxl_decoder_settings *settings)
>>>>> settings is replacing cxld, I would prefer that as the first parameter
>>>>>
>>>>>>     {
>>>>>> -    int id = cxld->config.id;
>>>>>> +    struct cxl_decoder_config *config = &settings->config;
>>>>>> +    int id = config->id;
>>>>>> +    u64 target_or_skip_reg_val;
>>>>>>         u64 base, size;
>>>>>>         u32 ctrl;
>>>>>>     -    /* common decoder settings */
>>>>>> -    ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->config.id));
>>>>>> -    cxld_set_interleave(cxld, &ctrl);
>>>>>> -    cxld_set_type(cxld, &ctrl);
>>>>>> -    base = cxld->config.hpa_range.start;
>>>>>> -    size = range_len(&cxld->config.hpa_range);
>>>>>> +    ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
>>>>>> +    cxld_set_interleave(config, &ctrl);
>>>>>> +    cxld_set_type(config, &ctrl);
>>>>>> +    base = config->hpa_range.start;
>>>>>> +    size = range_len(&config->hpa_range);
>>>>>> +    target_or_skip_reg_val = settings->target_or_skip_reg_val;
>>>>>>           writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
>>>>>>         writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
>>>>>>         writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
>>>>>>         writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
>>>>>> +    /* Target-list and endpoint-skip registers alias the same slot. */
>>>>>> +    writel(upper_32_bits(target_or_skip_reg_val), hdm + CXL_HDM_DECODER0_TL_HIGH(id));
>>>>>> +    writel(lower_32_bits(target_or_skip_reg_val), hdm + CXL_HDM_DECODER0_TL_LOW(id));
>>>>>> +
>>>>>> +    writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
>>>>>> +}
>>>>>> +
>>>>>> +void cxl_commit_start(void __iomem *hdm, struct cxl_decoder_settings *settings)
>>>>>> +{
>>>>>> +    lockdep_assert_held(&cxl_rwsem.dpa);
>>>>>> +    setup_hw_decoder(hdm, settings);
>>>>>> +}
>>>>>> +
>>>>>> +/*
>>>>>> + * Endpoint skip and switch targets have different owners. Keep that state with
>>>>>> + * its owning type and flatten it only into a transient register-programming
>>>>>> + * snapshot.
>>>>>> + */
>>>>>> +static void cxl_decoder_snapshot(struct cxl_decoder *cxld,
>>>>>> +                 struct cxl_decoder_settings *settings)
>>>>>> +{
>>>>>> +    lockdep_assert_held(&cxl_rwsem.dpa);
>>>>>> +
>>>>>> +    *settings = (struct cxl_decoder_settings) {
>>>>>> +        .config = cxld->config,
>>>>>> +    };
>>>>>>           if (is_switch_decoder(&cxld->dev)) {
>>>>>>             struct cxl_switch_decoder *cxlsd =
>>>>>>                 to_cxl_switch_decoder(&cxld->dev);
>>>>>> -        void __iomem *tl_hi = hdm + CXL_HDM_DECODER0_TL_HIGH(id);
>>>>>> -        void __iomem *tl_lo = hdm + CXL_HDM_DECODER0_TL_LOW(id);
>>>>>>             u64 targets;
>>>>>>               cxlsd_set_targets(cxlsd, &targets);
>>>>>> -        writel(upper_32_bits(targets), tl_hi);
>>>>>> -        writel(lower_32_bits(targets), tl_lo);
>>>>>> +        settings->target_or_skip_reg_val = targets;
>>>>>>         } else {
>>>>>>             struct cxl_endpoint_decoder *cxled =
>>>>>>                 to_cxl_endpoint_decoder(&cxld->dev);
>>>>>> -        void __iomem *sk_hi = hdm + CXL_HDM_DECODER0_SKIP_HIGH(id);
>>>>>> -        void __iomem *sk_lo = hdm + CXL_HDM_DECODER0_SKIP_LOW(id);
>>>>>>     -        writel(upper_32_bits(cxled->skip), sk_hi);
>>>>>> -        writel(lower_32_bits(cxled->skip), sk_lo);
>>>>>> +        settings->target_or_skip_reg_val = cxled->skip;
>>>>>>         }
>>>>>> -
>>>>>> -    writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
>>>>>>     }
>>>>>>       static int cxl_decoder_commit(struct cxl_decoder *cxld)
>>>>>> @@ -830,6 +851,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>>>>>>         struct cxl_port *port = to_cxl_port(cxld->dev.parent);
>>>>>>         struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
>>>>>>         void __iomem *hdm = cxlhdm->regs.hdm_decoder;
>>>>>> +    struct cxl_decoder_settings settings;
>>>>>>         int id = cxld->config.id, rc;
>>>>>>           if (cxld->config.flags & CXL_DECODER_F_ENABLE)
>>>>>> @@ -862,10 +884,12 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>>>>>>             }
>>>>>>         }
>>>>>>     -    scoped_guard(rwsem_read, &cxl_rwsem.dpa)
>>>>>> -        setup_hw_decoder(cxld, hdm);
>>>>>> +    scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
>>>>>> +        cxl_decoder_snapshot(cxld, &settings);
>>>>>> +        cxl_commit_start(hdm, &settings);
>>>>>> +    }
>>>>>>     -    rc = cxld_await_commit(hdm, cxld->config.id);
>>>>>> +    rc = cxld_await_commit(hdm, settings.config.id);
>>>>>>         if (rc) {
>>>>>>             dev_dbg(&port->dev, "%s: error %d committing decoder\n",
>>>>>>                 dev_name(&cxld->dev), rc);
>>>>>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>>>>>> index 237b31d54249..67c81be47fbb 100644
>>>>>> --- a/include/cxl/cxl.h
>>>>>> +++ b/include/cxl/cxl.h
>>>>>> @@ -72,6 +72,16 @@ struct cxl_decoder {
>>>>>>         void (*reset)(struct cxl_decoder *cxld);
>>>>>>     };
>>>>>>     +/**
>>>>>> + * struct cxl_decoder_settings - CXL HDM decoder programming snapshot
>>>>>> + * @config: common decoder configuration
>>>>>> + * @target_or_skip_reg_val: switch target list or endpoint skip register value
>>>>>> + */
>>>>>> +struct cxl_decoder_settings {
>>>>>> +    struct cxl_decoder_config config;
>>>>>> +    u64 target_or_skip_reg_val;
>>>>> Single variable contains multiple meanings gets confusing and messy when they are different values depending on context.
>>>>>
>>>>> How about something like:
>>>>>
>>>>> struct cxl_endpoint_decoder_settings {
>>>>>       struct cxl_decoder_config config;
>>>>>       u64 skips;
>>>>> };
>>>>>
>>>>> /* resource.c: common to both decoder types */
>>>>> static u32 cxl_hdm_write_range(void __iomem *hdm,
>>>>>                                 const struct cxl_decoder_config *config)
>>>>> {
>>>>>          int id = config->id;
>>>>>          u64 base = config->hpa_range.start;
>>>>>          u64 size = range_len(&config->hpa_range);
>>>>>          u32 ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
>>>>>
>>>>>          cxld_set_interleave(config, &ctrl);
>>>>>          cxld_set_type(config, &ctrl);
>>>>>          writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id))
>>>>>          writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
>>>>>          writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id))
>>>>>          writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
>>>>>          return ctrl;
>>>>> }
>>>>>
>>>>> void cxl_commit_start_endpoint(void __iomem *hdm,
>>>>>                                 const struct cxl_endpoint_decoder_settings *s)
>>>>> {
>>>>>          int id = s->config.id;
>>>>>          u32 ctrl;
>>>>>
>>>>>          lockdep_assert_held(&cxl_rwsem.dpa);
>>>>>          ctrl = cxl_hdm_write_range(hdm, &s->config);
>>>>>          writel(upper_32_bits(s->skip), hdm + CXL_HDM_DECODER0_SKIP_HIGH(id));
>>>>>          writel(lower_32_bits(s->skip), hdm + CXL_HDM_DECODER0_SKIP_LOW(id));
>>>>>          writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
>>>>> }
>>>>>
>>>>> void cxl_commit_start_switch(void __iomem *hdm,
>>>>>                               const struct cxl_decoder_config *config,
>>>>>                               u64 targets)
>>>>> {
>>>>>          int id = config->id;
>>>>>          u32 ctrl;
>>>>>
>>>>>          lockdep_assert_held(&cxl_rwsem.dpa);
>>>>>          ctrl = cxl_hdm_write_range(hdm, config);
>>>>>          writel(upper_32_bits(targets), hdm + CXL_HDM_DECODER0_TL_HIGH(id));
>>>>>          writel(lower_32_bits(targets), hdm + CXL_HDM_DECODER0_TL_LOW(id));
>>>>>          writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
>>>>> }
>>>>>
>>>>> /* hdm.c: cxl_decoder_commit() */
>>>>> scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
>>>>>          if (is_switch_decoder(&cxld->dev)) {
>>>>>                  struct cxl_switch_decoder *cxlsd =
>>>>>                          to_cxl_switch_decoder(&cxld->dev);
>>>>>                  u64 targets;
>>>>>
>>>>>                  cxlsd_set_targets(cxlsd, &targets);
>>>>>                  cxl_commit_start_switch(hdm, &cxld->config, targets);
>>>>>          } else {
>>>>>                  struct cxl_endpoint_decoder *cxled =
>>>>>                          to_cxl_endpoint_decoder(&cxld->dev);
>>>>>                  struct cxl_endpoint_decoder_settings s = {
>>>>>                          .config = cxld->config,
>>>>>                          .skip = cxled->skip,
>>>>>                  };
>>>>>
>>>>>                  cxl_commit_start_endpoint(hdm, &s);
>>>>>          }
>>>>> }
>>>> Hi Dave,
>>>>
>>>>
>>>> I think cxl_decoder_snapshot() also needs this struct cxl_decoder_settings to store current value of switch/endpoint decoder registers.
>>>>
>>>> But your implementation only defines a struct cxl_endpoint_decoder_settings, I suppose that we also need a struct cxl_switch_decoder_settings?
>>>>
>>>>
>>>> How about using a union in struct cxl_decoder_settings, I think it can resolve the "Single variable with multiple meanings" issue you mentioned. like that
>>>>
>>>> struct cxl_decoder_settings {
>>>>
>>>>       struct cxl_decoder_config config;
>>>>
>>>>       union {
>>>>
>>>>           u64 targets;    // used for switch decoders
>>>>
>>>>           u64 skips;        // used for endpoint decoders
>>>>
>>>>       };
>>>>
>>>> };
>>>>
>>> That was my first thought, but it does not look like the switch decoders need it at the moment. I had LLM do a refactor and this [1] is what it looks like. See if you agree.
>>>
>>> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl-type2-reset
>>>
>>> DJ
>> That looks good to me, I was thinking that the struct cxl_decoder_settings was also needed to cache HDM decoders registers of switch USPs during PCI enumeration, but I realize that this patchset is only for type2 device reset support, not need to consider switch ports reset.
>>
>> Seems like if a switch USP reset will destroy the HDM routing in type2 device under switch case, if we want to support it, we will need another patchset to cache decoders registers on switch USP?
> You are correct. I guess we cross that bridge when we get there?

Yes, I agree.


Ming

>
> DJ
>
>>
>> Ming
>>
>>>> Ming
>>>>
>>>>>> +};
>>>>>> +
>>>>>>     /*
>>>>>>      * Using struct_group() allows for per register-block-type helper routines,
>>>>>>      * without requiring block-type agnostic code to include the prefix.
