Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013047.outbound.protection.outlook.com [40.93.196.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FAC3E44E7;
	Thu,  1 Oct 2026 19:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790881990; cv=fail; b=IdA3dnbPlyxk1qqq8Ky2ulmemJCTH+ygHZihR1jhtS1Ud/ydZDppodLiy7YSXw7y3pTpbkKuvXY0YRqysgRpLMPICxRev0DHywmllzhbC0Wu/sndlqzJFosJgD/PlKfn2YKT03e7dKUoq+x5vDP4iaTwpKkYrV0d3VgmH/FU0BU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790881990; c=relaxed/simple;
	bh=+I0LrVFhzMQw/7rH3bq6IoyVoq+EKeQ03WPKSOxx7TY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ednYXTzNZ9lsiljuvWoZ3uOis2/hoeCprM6S5wHaLAJw6nzOtQcffpiqFGOdbE91NrALtzO9hatZXy6mmVOkCApZ1p82NOtuacNR0cHLyM6QltwyFsxwW8jGdMnKPiKYvAnyV8iYnqQ2VOJ8vNsQueAZK6ZhFjOQAvEuPhRZQ4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=leHwU4BI; arc=fail smtp.client-ip=40.93.196.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="leHwU4BI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0048i41OfVduog6atMP64Bz2WyqYQECTTyU7LlWkmnjKA51Kwu4H+63BR1T0BMVfSN1Jvn41XPdt5IC7A9a7mqF1iRj+Fd828WXvO3EOKRFGXVgtc4Vwt91LI3QGti559HYaGKhT8+pFYGArbQdUO0O8EvwKDO72xbvrvR6KNGd+pj3BeTTl97LbO5cIO1Kc3BUpDB8EUZJy1CTRjRd161Ge9HU2c7N22+7cEdxSk9TFqeqwoTrZF7r/sG2G07Qmywd2LozsgyAle2kfG/8ejnAz5MUDnfJCsQYKfkpIODiW+te8QWVqrs41JZWhsj1Orl51NvH75qQnk9rm6Seyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90UkghY0EFAcmu9MJmGIaZjEuhh0JSHJQUiJBtHHHKQ=;
 b=FhO/sqkCS/XzgNXdF1T+d3kIPf62cm6cvot220s3htuz4DjgThQy7DqFJU2jnu+cJ//5eQFskLwkNbv0PWCrem4TpSy2PFflHE/1AUo3DKsg48GYqaLMkon4kaHoBYUVaRnruq4UFGrvtqC9UC7YW6hBI0N2i6fEpanqYnuKqZBxYOGqH65NJTUjTWeahNHMCLaUM+OY9EKHwfNp6dRzzv/P1dMjV6gu5kX3HNLFrrT4Ej8lF8vEpvVuw1F0leIcaV2jBtt9Xmyk7sNLckK7VzrdbgpjlRIU5n6u90Sapcn8wK3Gelb37brG331QOTlp9PSGmQGa34QwGdheLG0ieA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90UkghY0EFAcmu9MJmGIaZjEuhh0JSHJQUiJBtHHHKQ=;
 b=leHwU4BIIEdb1okC4wZ0aYdgSbH/dnXINrHM3LOOnWkPKoIsNj391cAZJIaHOw+V1h0QUYpTwWYFTXXHSSNCBQGwC4zGU8yLgKnrhjgf05u7D9hN8XLuZTKfJDkgKUfm6aBX7KRGxW+qrKTegqR/vr9yLpiZb3uto/qa1vRpQsnlN+uAi3QjkwIbCbgwEVP5KWRhdRCLfYyK0nwQOsC9AapBCALCOqzh9ExWyN88LOHvspZgW5eeuL/+V3wLonHqQ/DO27PIPKnsn7pxr5ZupcN3WiP0rxSQDc7aZPEmOEE80PqTpd3cFx4qhAXAcRJi2/5VgNbqqa1b8OR5mnX8CA==
Received: from PH7PR10CA0012.namprd10.prod.outlook.com (2603:10b6:510:23d::26)
 by SN7PR12MB7204.namprd12.prod.outlook.com (2603:10b6:806:2ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Thu, 1 Oct
 2026 19:13:02 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:510:23d:cafe::93) by PH7PR10CA0012.outlook.office365.com
 (2603:10b6:510:23d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 19:13:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 19:13:02 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 12:12:36 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 12:12:36 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Thu, 1 Oct 2026 12:12:34 -0700
Date: Thu, 1 Oct 2026 12:12:32 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Daniel Mentz
	<danielmentz@google.com>, Ashish Mhetre <amhetre@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>, Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, <rafael@kernel.org>, "Danilo
 Krummrich" <dakr@kernel.org>, <driver-core@lists.linux.dev>
Subject: Re: [PATCH v11 16/16] iommu/arm-smmu-v3: Add KUnit unit tests for
 Runtime PM
Message-ID: <ar6woMRpqt4k6uBs@nvidia.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-17-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260929034510.2023173-17-praan@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|SN7PR12MB7204:EE_
X-MS-Office365-Filtering-Correlation-Id: b1577c31-4365-4250-2abd-08df1ff003e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|7416014|3023799007|11063799006|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1LBAdpsdhGKrh8kvqLfR7P2DqCpfUkclNjJwGqnmM0A0MtnQO+1CqMcB7KQeFtKWMyNvpau4GILZQEQwDd/Xo1vevk0C9CL6i1ZJ6aNorEKxMA2zHHY8pVdGNvXqE5263O/EN4b/Mk97osdRR6eCNGe7NrNKzoW88suXd9zOrFDEUaKX8gU9BMtBCg6vnJ+UnpnG7GvomNRch82SaHNQVJ1KJL45YcKXOW4LMj/m4aQdLw32ipnpHy2VyIs55DFHeCDhU1cv88md2kvI1RBUIX70j0EUEAlcAY9M+FfZutMjKp7IuCOxoTa4IM0l2qoZqvVdqOrOkBaocIfzebICFeH5lk5HUiWQM+Bwhb93q6wRdqpE5wpGKjgLHc1v9zEUh58OjxyxkjaauNe1tMXavHeNwLZ3uQFzT0gnQREvciLVomaJPyM/1r8iud0bzVovFGj+tUR863WJEdC3XeVRbSrE7s5zFUUMavbNZha8sKuiWfjlRzXuG6+TuUbXr/qebV0VHKb46azDZGP679l5WyVOcFLecvoc8nqxMSdX6GbJcZkVdxC9Av9MwGZx7FtxZu6Koa2WR3vvUoDB7O91wk1LLDAffaKbdfEJBdKHpKFr9ry5RhupNg1OlH0aQNMOQ03DO4BanGotyto42TnowyatFwRBaXFe7GfZaJqXCeQkR4eiJXhV7PU9kEwC0PVk2FJ0GDWbLKvFAJ5nAEe2OQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(7416014)(3023799007)(11063799006)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RfXdGjjfMQ8T6XXcqdxgDbUcibp3vmyM6NbATevvPt+xg3v3oLeOW1n+Xo6YTPLc0nvk9YGokYPxEz1ZbNfnN3Rzv7s+jFQf0M7mfbAr6kXjHPo2aft+Vaffcm9qkobzm2Vw6MZtYJ1uTfwnHTO1jbecAhVfXA6jz+lRsi55KPNZCMOGPohOPACFKAz1zaxc+7krWsjAhXmYc9rJieS0TzoN8w+G9Ru66zPPt2MVsxD7skwGnn3HaRT9bKeWBaskT36dI/u9KEkhFeSIPJF4QbDF3UaGditSDOaJjQJ/yC2zrXzjJiPnSdraqXTxRFYxQNwx8lrizYtG+A/SPcVimCRV/CH9d6mMmqfpb2F2wVPAwccOo23IXQ3HRXSqGHySWThuQ8purwGxe/qHDKbFBk8TTlnyleAJ0OYhtCbBhg3gh4U5nItA/F8RHanLThVa
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 19:13:02.7733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1577c31-4365-4250-2abd-08df1ff003e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7204

On Tue, Sep 29, 2026 at 03:45:10AM +0000, Pranjal Shrivastava wrote:
>  #include <kunit/test.h>
> +#include <linux/delay.h>
> +#include <linux/kthread.h>
> +#include <linux/sched.h>

kthread is used here, so sched is not necessary?

> +struct arm_smmu_mock_cmdq {
> +	/*
> +	 * Mock register in RAM. Typed as __le32 to match writel_relaxed()
> +	 * endianness without calling readl_* accessors directly on RAM.
> +	 */
> +	__le32 mock_prod_reg;
> +};
> +
> +/* Helper to allocate a self-consuming mock cmdq */
> +static void arm_smmu_v3_test_init_mock_cmdq(struct kunit *test,
> +					    struct arm_smmu_device *smmu,
> +					    struct arm_smmu_mock_cmdq *mock)
> +{
> +	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
> +	unsigned long *mock_valid_map;
> +	u64 *mock_base;
> +
> +	mock_base = kunit_kzalloc(test, 1024 * sizeof(struct arm_smmu_cmd), GFP_KERNEL);
> +	mock_valid_map = kunit_kzalloc(test, BITS_TO_LONGS(1024) * sizeof(long), GFP_KERNEL);
> +
> +	KUNIT_ASSERT_NOT_NULL(test, mock_base);
> +	KUNIT_ASSERT_NOT_NULL(test, mock_valid_map);
> +
> +	smmu->features = 0;
> +	/* 1024 entries */
> +	cmdq->q.llq.max_n_shift = 10;
> +	cmdq->q.ent_dwords = CMDQ_ENT_DWORDS;
> +	cmdq->q.base = (__le64 *)mock_base;
> +	cmdq->valid_map = (atomic_long_t *)mock_valid_map;
> +
> +	/* Self-Consuming, prod == cons always ensures queue empty */
> +	cmdq->q.prod_reg = (__force void __iomem *)&mock->mock_prod_reg;
> +	cmdq->q.cons_reg = (__force void __iomem *)&mock->mock_prod_reg;

Is it really necessary to return mock->mock_prod_reg?

mock_base and mock_valid_map are working well here.

Couldn't mock_prod_reg be allocated here, then the caller just uses
cmdq->q.prod_reg?

E.g.

static inline u32 arm_smmu_v3_test_read_prod(struct arm_smmu_cmdq *cmdq)
{
      return le32_to_cpu(READ_ONCE(*(__le32 __force *)cmdq->q.prod_reg));
}

> +struct arm_smmu_test_timer_context {
> +	struct arm_smmu_device *smmu;
> +	struct timer_list timer;
> +	bool suspended;
> +};
> +
> +static void arm_smmu_v3_test_rpm_timer_callback(struct timer_list *t)
> +{
> +	struct arm_smmu_test_timer_context *ctx =
> +		timer_container_of(ctx, t, timer);
> +	struct arm_smmu_cmdq *cmdq = &ctx->smmu->cmdq;
> +
> +	/* Simulate a concurrent suspend event interrupting the invalidations */
> +	atomic_or(CMDQ_PROD_STOP_FLAG, &cmdq->q.llq.atomic.prod);
> +	WRITE_ONCE(ctx->suspended, true);

Both STOP and suspended flags are set at the same time, seemingly
a bit redundant to me..

> +struct arm_smmu_test_kthread_context {
> +	struct arm_smmu_device *smmu;
> +	int error;
> +};
> +
> +static int arm_smmu_v3_test_kthread_worker(void *data)
> +{
> +	struct arm_smmu_cmd cmd = arm_smmu_make_cmd_cfgi_all();
> +	struct arm_smmu_test_kthread_context *ctx = data;
> +	struct arm_smmu_cmdq *cmdq = &ctx->smmu->cmdq;
> +
> +	while (!kthread_should_stop()) {
> +		if (arm_smmu_cmdq_issue_cmdlist(ctx->smmu, cmdq, &cmd, 1, false))
> +			WRITE_ONCE(ctx->error, 1);

With "sync=false", arm_smmu_cmdq_issue_cmdlist cannot fail. I don't
see any "sync=true" call site in this patch. But even there was one,
would the mock cmdq ever time out?

So, error (and arm_smmu_test_kthread_context) seems useless?

> +static void arm_smmu_v3_rpm_test_kthread_race(struct kunit *test)
> +{
> +	struct arm_smmu_test_kthread_context *ctx;
> +	struct arm_smmu_device *mock_smmu;
> +	struct arm_smmu_mock_cmdq *mock;
> +	struct task_struct *thread1, *thread2;
> +	u32 stopped_prod;
> +	int i;
> +
> +	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
> +	mock_smmu = kunit_kzalloc(test, sizeof(*mock_smmu), GFP_KERNEL);

The other function simply does:
	struct arm_smmu_device mock_smmu = smmu;

> +	/* Wait for worker threads to start and issue initial commands */
> +	for (i = 0; i < 20; i++) {

I am a bit confused by the number in the for loop: it's 20 here...

> +	KUNIT_EXPECT_GT(test, le32_to_cpu(READ_ONCE(mock->mock_prod_reg)), 0);
> +
> +	/* Gate the CMDQ */
> +	atomic_or(CMDQ_PROD_STOP_FLAG, &mock_smmu->cmdq.q.llq.atomic.prod);
> +
> +	/* Wait for in-flight submissions to settle */
> +	for (i = 0; i < 50; i++) {

... but it's 50 here. Mind elaborating?

Nicolin
