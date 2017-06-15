Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20170615002358.GD28496@leoy-ThinkPad-T440>
References: <20170614082338.15673-1-guodong.xu@linaro.org>
 <20170614082338.15673-15-guodong.xu@linaro.org>
 <20170615002358.GD28496@leoy-ThinkPad-T440>
From: Guodong Xu <guodong.xu@linaro.org>
Date: Thu, 15 Jun 2017 10:55:07 +0800
Message-ID: <CAFGCpxyxUnML7E_vszXAX=sHOgHFEBcYkXxY=tfNK5YC9NariA@mail.gmail.com>
Subject: Re: [PATCH v3 14/21] arm64: dts: hi3660: enable idle states
To: Leo Yan <leo.yan@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
 Kevin Wang <jean.wangtao@linaro.org>, linux-pci <linux-pci@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, linux-mmc@vger.kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, "xuwei \(O\)" <xuwei5@hisilicon.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Rob Herring <robh+dt@kernel.org>,
 "Chenfeng \(puck\)" <puck.chen@hisilicon.com>,
 Xuejiancheng <xuejiancheng@hisilicon.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>, Lee Jones <lee.jones@linaro.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 15, 2017 at 8:23 AM, Leo Yan <leo.yan@linaro.org> wrote:
> On Wed, Jun 14, 2017 at 04:23:31PM +0800, Guodong Xu wrote:
>> From: Leo Yan <leo.yan@linaro.org>
>>
>> On Hi3660 there have two clusters, one is CA53 cluster and another is
>> CA73 cluster. This two clusters have different idle states separately.
>> With Daniel Lezcano's patch (ARM: cpuidle: Support asymmetric idle
>> definition), now ARM idle driver can support different clusters with
>> different idle states.
>>
>> Base on this, this patch is to bind two clusters idle states on Hi3660.
>> Except the "WFI" states are enabled by default for all CPUs, this patch
>> also binds below extra idle states:
>>
>> - CA53 CPUs have two more states:
>>   CPU_SLEEP:       CPU power off state
>>   CLUSTER_SLEEP_0: Cluster power off state
>>
>> - CA73 CPUs have three more states:
>>   CPU_NAP:         CPU retention state
>>   CPU_SLEEP:       CPU power off state
>>   CLUSTER_SLEEP_1: Cluster power off state
>
> Hi Guodong, Wei and all,
>
> As Daniel reminded, this patch is dependent on patch (ARM: cpuidle:
> Support asymmetric idle definition) [1] but his patch has not been
> finally merged yet. So let us hold on this patch for Daniel's patch
> is picked up firstly.
>
> At the meantime welcome the review and comment for this patch ahead.
>

Ok, so, I will drop this patch, and resend my patchset as v4.

-Guodong

> [1] https://patchwork.kernel.org/patch/9781869/
>
> [...]
>
> Thanks,
> Leo Yan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
