Return-Path: <SRS0=v2Vw=SP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3677C10F11
	for <linux-pci@archiver.kernel.org>; Sat, 13 Apr 2019 09:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF18A2084E
	for <linux-pci@archiver.kernel.org>; Sat, 13 Apr 2019 09:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W00Wf8yC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfDMJND (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 13 Apr 2019 05:13:03 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50212 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfDMJND (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 13 Apr 2019 05:13:03 -0400
Received: by mail-wm1-f68.google.com with SMTP id z11so14145526wmi.0
        for <linux-pci@vger.kernel.org>; Sat, 13 Apr 2019 02:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6j2+oAhD+dZrLXexKNZ1uylOYS7hAH/o/Lb0V4eYN5E=;
        b=W00Wf8yC1rBTZoBV4F1S9JocEDvSfEmtfMsoeCUrIgmQd1IxU3k4lSBARY1f/YFWtc
         GX/M7C6rJbHayMcTEgn25A+5V7bYUWuL+qcGtZQlCiugo1N6Yo0BIjfBIBFhWUCixSUH
         uieFBDdPzcoJDUyjz8QjJoQ2KoqxU6Nlmokpobo9VmrGAqzmvd4YbNn064SEYzcSu7YV
         CR1y5Me2/Yl/sjK/0y+6zLDOFqdN1Bf3AVD0rpxV4295PvciKuAGe1eo5kRvobU7rU6R
         yrr+f/5xzYkR0eYPovtPWHebaSuMLjHv9QhJRb1GG5oq9vb6zwsyE1Du63fiA4/vgZKr
         BMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6j2+oAhD+dZrLXexKNZ1uylOYS7hAH/o/Lb0V4eYN5E=;
        b=bMfBqNrLT47iCn87NRY+520MTuTLKCyG/8xN4N8ji3QjJHY3OUgzE2ZpqjHvvDbfpg
         hRxpQmXsoQah0lF10k0SpK+dhlwWF1oBvgSOJGzdgzGACaSdwpR95MXrJ7ri4PQPHvbH
         oCiSHFjMk6Ua3NtV1AQeH9UekY92Ze91rJZtECf2pz+o6CeCBD0iHZxDLg5Moe0bFrll
         j/ED7/1CCuqoCATtGF5/vlmzPX+GoA7DAPAhrJZuUVgUguMKngn4ZfDn6sGY3zzMrTa/
         jxgmXyOKeE124TPpOnksFzQkJanVsTwR2Wk1pQeaVUqRwH0df1xuZaaAFXhAHjMdTkHs
         7buA==
X-Gm-Message-State: APjAAAVAq+U8aKCknpVEEyinz7BF8wmMy/foa7494kT+XjqrrETjsFnU
        jzJOWCgB2CHJZfTOeZrXtXtKTeVZ
X-Google-Smtp-Source: APXvYqzCCnFkAVs+thC4M8B0E5ySmGL8byrmbq6zo87gxExN0L3yCJ2L//CxKKc6xEt9IFSFOls7hg==
X-Received: by 2002:a1c:6342:: with SMTP id x63mr14854757wmb.58.1555146780322;
        Sat, 13 Apr 2019 02:13:00 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:6509:80dd:f4f:5628? (p200300EA8BD45700650980DD0F4F5628.dip0.t-ipconnect.de. [2003:ea:8bd4:5700:6509:80dd:f4f:5628])
        by smtp.googlemail.com with ESMTPSA id 11sm10710460wmk.17.2019.04.13.02.12.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 02:12:59 -0700 (PDT)
Subject: [PATCH RFC 3/3] PCI/ASPM: add sysfs attribute for controlling ASPM
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <e63cec92-cfb1-d0c4-f21e-350b4b289849@gmail.com>
Message-ID: <a0a39450-1f23-f5a0-d669-3d722e5b71dd@gmail.com>
Date:   Sat, 13 Apr 2019 11:12:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e63cec92-cfb1-d0c4-f21e-350b4b289849@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Background of this extension is a problem with the r8169 network driver.
Several combinations of board chipsets and network chip versions have
problems if ASPM is enabled, therefore we have to disable ASPM per
default. However especially on notebooks ASPM can provide significant
power-saving, therefore we want to give users the option to enable
ASPM. With the new sysfs attribute users can control which ASPM
link-states are disabled.

This is a first RFC version, therefore documentation of attribute is
still missing. The attribute handling was inspired by the protocol
attribute handling in drivers/media/rc/rc-main.c.
Attribute syntax in a few words:
none: allow all supported ASPM states
all: disable all ASPM states
+<state>: add state to list of disabled ASPM states
-<state>: re-enable ASPM state if supported

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/pci.h       |   8 +-
 drivers/pci/pcie/aspm.c | 173 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 173 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index d994839a3..6d4e5fc24 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -499,17 +499,13 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev);
 void pcie_aspm_exit_link_state(struct pci_dev *pdev);
 void pcie_aspm_pm_state_change(struct pci_dev *pdev);
 void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
+void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev);
+void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev);
 #else
 static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
 static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
-#endif
-
-#ifdef CONFIG_PCIEASPM_DEBUG
-void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev);
-void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev);
-#else
 static inline void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev) { }
 static inline void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev) { }
 #endif
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 7847be38e..bfbfd9134 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -42,6 +42,8 @@
 #define ASPM_STATE_ALL		(ASPM_STATE_L0S | ASPM_STATE_L1 |	\
 				 ASPM_STATE_L1SS)
 
+static const char power_group[] = "power";
+
 struct aspm_latency {
 	u32 l0s;			/* L0s latency (nsec) */
 	u32 l1;				/* L1 latency (nsec) */
@@ -1251,8 +1253,164 @@ static ssize_t clk_ctl_store(struct device *dev,
 
 static DEVICE_ATTR_RW(link_state);
 static DEVICE_ATTR_RW(clk_ctl);
+#endif
+
+struct aspm_sysfs_state {
+	const char *name;
+	int disable_mask;
+};
+
+static const struct aspm_sysfs_state aspm_sysfs_states[] = {
+	{ "L0S",	ASPM_STATE_L0S		},
+	{ "L1",		ASPM_STATE_L1		},
+	{ "L1.1",	ASPM_STATE_L1_1_MASK	},
+	{ "L1.2",	ASPM_STATE_L1_2_MASK	},
+};
+
+static struct pci_dev *aspm_get_parent(struct pci_dev *pdev)
+{
+	struct pci_dev *parent = pdev->bus->self;
+
+	if (pdev->has_secondary_link)
+		parent = pdev;
+
+	return parent && parent->link_state ? parent : NULL;
+}
+
+static ssize_t aspm_disable_link_state_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct pci_dev *parent, *pdev = to_pci_dev(dev);
+	struct pcie_link_state *link;
+	int len = 0, i;
+
+	parent = aspm_get_parent(pdev);
+	if (!parent)
+		return -EOPNOTSUPP;
+
+	link = parent->link_state;
+
+	mutex_lock(&aspm_lock);
+
+	for (i = 0; i < ARRAY_SIZE(aspm_sysfs_states); i++) {
+		const struct aspm_sysfs_state *st = aspm_sysfs_states + i;
+
+		if (link->aspm_disable & st->disable_mask)
+			len += scnprintf(buf + len, PAGE_SIZE - len, "[%s] ",
+					 st->name);
+		else
+			len += scnprintf(buf + len, PAGE_SIZE - len, "%s ",
+					 st->name);
+	}
+
+	if (link->clkpm_disable)
+		len += scnprintf(buf + len, PAGE_SIZE - len, "[CLKPM] ");
+	else
+		len += scnprintf(buf + len, PAGE_SIZE - len, "CLKPM ");
+
+	mutex_unlock(&aspm_lock);
+
+	len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
+
+	return len;
+}
+
+static ssize_t aspm_disable_link_state_store(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf, size_t len)
+{
+	struct pci_dev *parent, *pdev = to_pci_dev(dev);
+	struct pcie_link_state *link;
+	char *buftmp = (char *)buf, *tok;
+	unsigned int disable_aspm, disable_clkpm;
+	bool first = true, add;
+	int err = 0, i;
+
+	if (aspm_disabled)
+		return -EPERM;
+
+	parent = aspm_get_parent(pdev);
+	if (!parent)
+		return -EOPNOTSUPP;
+
+	link = parent->link_state;
+
+	down_read(&pci_bus_sem);
+	mutex_lock(&aspm_lock);
+
+	disable_aspm = link->aspm_disable;
+	disable_clkpm = link->clkpm_disable;
+
+	while ((tok = strsep(&buftmp, " \n")) != NULL) {
+		bool found = false;
+
+		if (!*tok)
+			continue;
+
+		if (first) {
+			if (!strcasecmp(tok, "none")) {
+				disable_aspm = 0;
+				disable_clkpm = 0;
+				break;
+			}
+			if (!strcasecmp(tok, "all")) {
+				disable_aspm = ASPM_STATE_ALL;
+				disable_clkpm = 1;
+				break;
+			}
+			first = false;
+		}
+
+		if (*tok != '+' && *tok != '-') {
+			err = -EINVAL;
+			goto out;
+		}
+
+		add = *tok++ == '+';
+
+		for (i = 0; i < ARRAY_SIZE(aspm_sysfs_states); i++) {
+			const struct aspm_sysfs_state *st =
+						aspm_sysfs_states + i;
+
+			if (!strcasecmp(tok, st->name)) {
+				if (add)
+					disable_aspm |= st->disable_mask;
+				else
+					disable_aspm &= ~st->disable_mask;
+				found = true;
+				break;
+			}
+		}
+
+		if (!found && !strcasecmp(tok, "clkpm")) {
+			disable_clkpm = add ? 1 : 0;
+			found = true;
+		}
+
+		if (!found) {
+			err = -EINVAL;
+			goto out;
+		}
+	}
+
+	if (disable_aspm & ASPM_STATE_L1)
+		disable_aspm |= ASPM_STATE_L1SS;
+
+	link->aspm_disable = disable_aspm;
+	link->clkpm_disable = disable_clkpm;
+
+	pcie_config_aspm_link(link, policy_to_aspm_state(link));
+	pcie_set_clkpm(link, policy_to_clkpm_state(link));
+out:
+	mutex_unlock(&aspm_lock);
+	up_read(&pci_bus_sem);
+
+	return err ?: len;
+}
+
+static DEVICE_ATTR_RW(aspm_disable_link_state);
 
-static char power_group[] = "power";
 void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev)
 {
 	struct pcie_link_state *link_state = pdev->link_state;
@@ -1260,12 +1418,18 @@ void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev)
 	if (!link_state)
 		return;
 
+	if (link_state->aspm_support)
+		sysfs_add_file_to_group(&pdev->dev.kobj,
+			&dev_attr_aspm_disable_link_state.attr, power_group);
+
+#ifdef CONFIG_PCIEASPM_DEBUG
 	if (link_state->aspm_support)
 		sysfs_add_file_to_group(&pdev->dev.kobj,
 			&dev_attr_link_state.attr, power_group);
 	if (link_state->clkpm_capable)
 		sysfs_add_file_to_group(&pdev->dev.kobj,
 			&dev_attr_clk_ctl.attr, power_group);
+#endif
 }
 
 void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev)
@@ -1275,14 +1439,19 @@ void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev)
 	if (!link_state)
 		return;
 
+	if (link_state->aspm_support)
+		sysfs_remove_file_from_group(&pdev->dev.kobj,
+			&dev_attr_aspm_disable_link_state.attr, power_group);
+
+#ifdef CONFIG_PCIEASPM_DEBUG
 	if (link_state->aspm_support)
 		sysfs_remove_file_from_group(&pdev->dev.kobj,
 			&dev_attr_link_state.attr, power_group);
 	if (link_state->clkpm_capable)
 		sysfs_remove_file_from_group(&pdev->dev.kobj,
 			&dev_attr_clk_ctl.attr, power_group);
-}
 #endif
+}
 
 static int __init pcie_aspm_disable(char *str)
 {
-- 
2.21.0


